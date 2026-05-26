## 1. ルーティングとコントローラー

- [ ] 1.1 `config/routes.rb` の `resources :todos` に `edit` を追加
- [ ] 1.2 `todos_controller.rb` の `before_action :set_todo` に `:edit` を追加
- [ ] 1.3 `todos_controller.rb` に `edit` アクションを追加

## 2. ビュー: レイアウトとモーダル基盤

- [ ] 2.1 `app/views/layouts/application.html.erb` にモーダル用 `turbo_frame_tag "modal"` を追加
- [ ] 2.2 `app/views/todos/edit.html.erb` を新規作成（モーダルHTML、タイトル入力フォーム、保存・キャンセルボタン）

## 3. ビュー: タスク一覧と更新処理

- [ ] 3.1 `app/views/todos/_todo.html.erb` に「編集」ボタンを追加（`edit_todo_path` へのリンク、`data-turbo-frame="modal"`）
- [ ] 3.2 `app/views/todos/update.turbo_stream.erb` にモーダルを空にする `turbo_stream.replace("modal", "")` を追加

## 4. スタイル

- [ ] 4.1 モーダルのCSS（オーバーレイ、ダイアログボックス、ボタン配置）を追加
