## Why

タスク作成後にタイトルを修正する手段がなく、誤入力した場合は削除して再作成するしかない。編集機能を追加することでユーザーの操作性を向上させる。

## What Changes

- タスク一覧の各アイテムに「編集」ボタンを追加
- 編集ボタンクリックでモーダルダイアログを表示し、タイトルを編集できる
- 保存するとタスクのタイトルが更新され、モーダルが閉じる
- キャンセルするとモーダルが閉じ、変更は破棄される

## Capabilities

### New Capabilities

- `todo-edit-modal`: モーダルダイアログでのタスクタイトル編集機能

### Modified Capabilities

## Impact

- `app/controllers/todos_controller.rb`: `edit` アクションの追加
- `config/routes.rb`: `edit` ルートの追加
- `app/views/todos/_todo.html.erb`: 編集ボタンの追加
- `app/views/todos/edit.html.erb`: 新規作成（モーダルHTML）
- `app/views/todos/update.turbo_stream.erb`: モーダルを閉じる処理の追加
- `app/views/layouts/application.html.erb`: モーダル用 `turbo_frame_tag "modal"` の追加
- `app/assets/stylesheets/`: モーダルのCSS追加
