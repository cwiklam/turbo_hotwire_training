class Todo < ApplicationRecord
  after_commit :publish_todo, on: :create

  def publish_todo
    broadcast_replace_to 'todos_stream', target: 'new_todo', partial: "todos/form", locals: { todo: Todo.new, frame_id: 'new_todo' }
    broadcast_append_to 'todos_stream', target: 'todos_list', partial: 'todos/item', locals: { todo: self }
  end
end
