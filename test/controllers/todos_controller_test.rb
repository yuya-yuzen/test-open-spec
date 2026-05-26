require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = Todo.create!(title: "テストタスク", completed: false)
  end

  test "GET /todos はHTTP 200を返す" do
    get todos_path
    assert_response :success
  end

  test "POST /todos で Todo を作成できる" do
    assert_difference("Todo.count", 1) do
      post todos_path, params: { todo: { title: "新しいタスク" } }
    end
  end

  test "POST /todos でタイトルが空の場合は作成されない" do
    assert_no_difference("Todo.count") do
      post todos_path, params: { todo: { title: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "PATCH /todos/:id で completed を更新できる" do
    patch todo_path(@todo), params: { todo: { completed: true } }
    assert @todo.reload.completed
  end

  test "DELETE /todos/:id で Todo を削除できる" do
    assert_difference("Todo.count", -1) do
      delete todo_path(@todo)
    end
  end

  test "GET /todos/:id/edit はHTTP 200を返す" do
    get edit_todo_path(@todo)
    assert_response :success
  end

  test "PATCH /todos/:id でタイトルを更新できる" do
    patch todo_path(@todo), params: { todo: { title: "更新後のタスク" } }, as: :turbo_stream
    assert_equal "更新後のタスク", @todo.reload.title
    assert_response :success
  end

  test "PATCH /todos/:id でタイトルが空の場合はエラーレスポンスを返す" do
    patch todo_path(@todo), params: { todo: { title: "" } }, as: :turbo_stream
    assert_equal "テストタスク", @todo.reload.title
    assert_response :unprocessable_entity
  end
end
