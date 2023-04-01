class TodosController < ApplicationController
  def edit
    @todo = Todo.find(params[:id])
    Turbo::StreamsChannel.broadcast_replace_to 'todos_stream', target: "todo_status_#{@todo.id}", partial: 'todos/status'
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
  end

  def create
    @todo = Todo.create(todo_params)
    @todos = Todo.all
    # respond_to do |format|
    #   format.turbo_stream
    # end
  end

  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
