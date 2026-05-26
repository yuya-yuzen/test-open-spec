class TodosController < ApplicationController
  def index
    @todos = Todo.order(created_at: :desc)
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      @todos = Todo.order(created_at: :desc)
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
    @todo = Todo.find(params[:id])
    @todo.update!(todo_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path }
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path }
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
