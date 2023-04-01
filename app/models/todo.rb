class Todo < ApplicationRecord
  after_commit :publish_todo, on: :create
  after_commit :publish_update_todo, on: :update

  def publish_todo
    broadcast_append_to 'todos_stream', target: 'todos_list', partial: 'todos/item', locals: { todo: self }
  end

  def publish_update_todo
    broadcast_replace_to 'todos_stream', target: "todo_#{id}", partial: 'todos/item', locals: { todo: self }
  end
end
