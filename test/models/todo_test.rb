require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "title が空の場合は無効" do
    todo = Todo.new(title: "")
    assert_not todo.valid?
    assert_includes todo.errors[:title], "can't be blank"
  end

  test "title がある場合は有効" do
    todo = Todo.new(title: "買い物")
    assert todo.valid?
  end

  test "completed のデフォルトは false" do
    todo = Todo.new(title: "テスト")
    assert_equal false, todo.completed
  end
end
