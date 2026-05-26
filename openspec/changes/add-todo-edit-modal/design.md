## Context

現在のTodoアプリはTurbo Stream / Turbo Frameを中心に構築されており、タスクの作成・完了トグル・削除はすでにHotwireで実装されている。コントローラーには `update` アクションが存在するが、`edit` アクションがなく、タイトルの編集手段がない。

## Goals / Non-Goals

**Goals:**
- Turbo Frameを使ったモーダルダイアログでタイトル編集を実現する
- 既存のHotwire構成に沿った実装で、JSを新たに書かない
- 保存後はリストを即時更新し、モーダルを閉じる

**Non-Goals:**
- `completed` 状態の編集（既存のチェックボックスで対応済み）
- バリデーションエラー時の詳細なエラーメッセージ表示（基本的なエラー表示のみ）
- モーダル外クリックによるオーバーレイ閉じ（キャンセルボタンのみ）

## Decisions

### モーダルの実装: Turbo Frame を採用

`<turbo-frame id="modal">` をレイアウトに常駐させ、編集時にサーバーからモーダルHTMLを返す。

- **採用理由**: Stimulus JSを追加せずに実現でき、このアプリのHotwire構成と一致する
- **代替案**: Stimulus JSでモーダルを制御する → JS追加が必要でオーバーキル

### キャンセルの実装: turbo_stream でモーダルを空にする

キャンセルリンクは `data-turbo-action` を使わず、専用のキャンセルルートを設けずに、`edit.html.erb` 内で `<a href="#" data-turbo-frame="modal" href="...">` を用いるか、または `update.turbo_stream.erb` と同様にモーダルを空のフレームに置き換える。

実際には `edit.html.erb` 内のキャンセルボタンを `<a>` タグで `todos_path` へ `turbo-frame="modal"` 付きでリンクし、`index` を返すことで modal フレームをクリアする方法が最もシンプル。ただし `index` が modal フレームを含まない場合は空になる（意図通り）。

### 保存後のモーダル閉じ: turbo_stream.replace で空にする

`update.turbo_stream.erb` に `turbo_stream.replace("modal", "")` を追加し、リスト更新と同時にモーダルを閉じる。

## Risks / Trade-offs

- [モーダル外クリックで閉じない] → ユーザーがキャンセルボタンを探す必要があるが、シンプルさを優先。必要であれば後からStimulusで対応可能
- [`index` をキャンセル先にすると余分なデータ取得が発生] → タスク数が少ないため現時点では問題なし
