class Todo < ApplicationRecord
  #after_commit :publish_todo, on: :create

  def publish_todo
    broadcast_update_to 'todos_stream', target: 'todos_list', partial: 'todos/list', locals: { todos: Todo.all}
  end
end
