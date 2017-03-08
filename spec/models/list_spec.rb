require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Chores")
      task_names = ["Take out papers", "Take out trash", "go spend some spending cash"]
      task_names.each do |task_name|
        Task.create(list_id: list.id, name: task_name, complete: false)
      end

      list.complete_all_tasks!

     list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should push dealine for each task back by one hour' do
      deadline_time = DateTime.new(2001,5,29)
      list = List.create(name: "Chores")
      task_names = ["Take out papers", "Take out trash", "go spend some spending cash"]
      task_names.each do |task_name|
        Task.create(list_id: list.id, name: task_name, deadline: deadline_time)
      end

      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(deadline_time + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it "should return the sum of all tasks' durations" do
      list = List.create(name: "Chores")
      task_infos = [["Take out papers", 5],
                    ["Take out trash", 60],
                    ["go spend some spending cash", 12]]
      task_infos.each do |task_info|
        Task.create(list_id: list.id, name: task_info[0], duration: task_info[1])
      end

      expect(list.total_duration).to eq(77)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return all incomplete tasks from the list' do
      list = List.create(name: "Chores")
      task_infos = [["Take out papers", true],
                    ["Take out trash", false],
                    ["go spend cash", false],
                    ["go to bread", true]]
      task_infos.each do |task_info|
        Task.create(list_id: list.id, name: task_info[0], complete: task_info[1])
      end

      expect(list.incomplete_tasks.count).to eq(2)
      expect(list.incomplete_tasks.first.name).to eq("Take out trash")
      expect(list.incomplete_tasks).to be_a(Array)
      expect(list.incomplete_tasks).to eq(Task.where(complete: false, list_id: list.id))
    end
  end

  describe '#favorite_tasks' do
     it 'should return all favorite tasks from the list' do
       list = List.create(name: "Chores")
       task_infos = [["Take out papers", true],
                     ["Take out trash", false],
                     ["go spend cash", false],
                     ["go to bread", true]]
       task_infos.each do |task_info|
         Task.create(list_id: list.id, name: task_info[0], favorite: task_info[1])
       end

       expect(list.favorite_tasks.count).to eq(2)
       expect(list.favorite_tasks.first.name).to eq("Take out papers")
       expect(list.favorite_tasks).to be_a(Array)
       expect(list.favorite_tasks).to eq(Task.where(favorite: true, list_id: list.id))
     end
   end
end






