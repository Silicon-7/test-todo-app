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
end
