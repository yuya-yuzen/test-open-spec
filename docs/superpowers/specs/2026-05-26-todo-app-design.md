# ToDo アプリ設計ドキュメント

## コンテキスト

検証目的の簡易 ToDo アプリ。Rails 8.1 + Hotwire (Turbo Frames) の動作確認が目的。

## アーキテクチャ

Rails 8.1 の標準構成。Turbo Frames でページリロードなし操作を実現する。フロントエンドライブラリは追加しない。

## モデル

**Todo**
- `title: string` — タスク名（必須）
- `completed: boolean` — 完了フラグ（デフォルト: false）

バリデーション: `title` の presence のみ。

## コントローラ

**TodosController**

| アクション | HTTPメソッド | パス | 説明 |
|-----------|------------|------|------|
| index | GET | /todos | 一覧表示 |
| create | POST | /todos | 新規作成 |
| update | PATCH | /todos/:id | 完了トグル |
| destroy | DELETE | /todos/:id | 削除 |

## ビュー構成

```
app/views/todos/
  index.html.erb      # メイン画面
  _todo.html.erb      # 個別Todoのパーシャル（Turbo Frame対応）
  _form.html.erb      # 入力フォームのパーシャル
```

### Turbo Frames

- `<turbo-frame id="todos">` — Todoリスト全体を囲む
- `<turbo-frame id="todo_<id>">` — 個別Todoを囲む（更新・削除用）
- フォーム送信後、`turbo_stream` でリストに追加 & フォームリセット

## データフロー

1. ユーザーがフォームにタイトルを入力し送信
2. `TodosController#create` が `Todo` レコードを作成
3. Turbo Stream レスポンスで `<turbo-frame id="todos">` 内の先頭に新アイテムを prepend
4. チェックボックスクリック → `PATCH /todos/:id` → `completed` を反転
5. 削除ボタン → `DELETE /todos/:id` → Turbo Stream で該当 frame を削除

## エラーハンドリング

- `title` が空の場合、バリデーションエラーでフォームを再描画
- それ以外のエラーは考慮しない（検証目的のため）

## スタイリング

素の CSS を `app/assets/stylesheets/application.css` に記述。最小限のスタイルのみ。

## テスト

手動確認のみ（検証用途のため）:
1. `bin/rails server` で起動
2. `http://localhost:3000/todos` を開く
3. タスクの追加・完了トグル・削除が動作することを確認
