class TodosController < ApplicationController
  before_action :set_todo, only: [ :update, :destroy ]

  def index
    load_todos
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      load_todos
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to todos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("todo_form", partial: "form", locals: { todo: @todo }) }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to todos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@todo), partial: "todo", locals: { todo: @todo }) }
        format.html { redirect_to todos_path }
      end
    end
  end

  def destroy
    @todo.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path }
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def load_todos
    @todos = Todo.order(created_at: :desc)
  end

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
