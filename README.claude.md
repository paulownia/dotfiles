# Claude Code 設定ガイド

`claude/settings.json` の編集方針をまとめる。

## パーミッション設定の方針

- 安全が確保されている限り承認プロンプトなしで実行可能にする。
- プロンプトが出るということは想定外のリソースアクセスが発生したものとみなし、settings.jsonにて自動承認の対象とすべきか検討する。


### permissions.defaultMode

`"default"` を使用する。allow/denyに含まれないツール呼び出しは都度ユーザーに確認が入る。

### permissions.allow

allowにマッチしたツールは自動承認される

- Read, Grep, Globはデフォルトで自動承認されるので追加しない
- Bashツールは `autoAllowBashIfSandboxed` で実行が許可されるので追加しない
- Edit, Writeはプロジェクト内のファイル(`/**`)を自動承認

### permissions.deny

denyにマッチしたものは確認プロンプトすら出さずに即ブロックされる

- 対象: 認証情報・秘密鍵など、誤って読まれると致命的なファイルをブロック
- Bashツールはsandboxの機能でブロックするので、ここには追加しない

### 優先順位

deny > ask > allow > defaultMode の順で評価される。

## sandbox

sandboxはBashツールとそのサブプロセスに対する制限。その目的はセキュリティ確保と確認プロンプトの削減

### sandboxの制限

- コマンドによる書き込みは、プロジェクト内であれば許可、プロジェクト外はエラー
- コマンドによる読み込みは、ファイルシステム全体で許可
- ネットワークアクセスは、許可ドメインは自動承認、それ以外は承認プロンプトの表示

### sandboxの適用範囲

- Bashツールはsandbox内で実行されるため、`denyWithinAllow` 等のファイルシステム制限が適用される
- Write/Edit/Read/Glob等の組み込みツールはClaude Codeプロセス自身が直接操作するため、sandbox制限を受けない
- この挙動は一貫性がないので、将来のアップデートで変更される可能性も考慮する

### 基本方針

- sandboxを有効にする
  - sandboxでコマンドによるプロジェクト外への変更を禁止（sandboxのデフォルト制限）
  − sandbox内であれば承認なしでのコマンド実行を行う
    - `autoAllowBashIfSandboxed: true`
  - sandbox外でのコマンド実行を抑制
    - `allowUnsandboxedCommands: false`
    - `excludedCommands`で指定されたコマンドはsandbox外での実行が可能

### filesystem.allowWrite

例えば、claude codeからnpm iなどを実行する場合、~/.npmを追加する必要があるかもしれない。これはNodeプロジェクト固有なのでプロジェクトレベルで有効にすること

### filesystem.denyRead

permissions.denyの指定と同じパスが拒否されるように指定。

### sandbox外のコマンド実行について

ghコマンドはsandboxの例外に追加し、sandbox外で実行する

#### 理由

goのツールのHTTPSアクセスがsandboxによりエラーになる。これは証明書ストアへのアクセスが拒絶されるため

#### 対応

- `sandbox.excludedCommands`にghを追加
- `permissions.allow`に次のghサブコマンドを追加し、確認プロンプトを省略
  - `issue`
  - `pr`
  - `search`
  - `release`
- permissions.denyに次のサブコマンドを追加し、実行を抑制
  - `codespace (cs)`: ローカルで開発するのでcodespaceを使用しないので
  - `extension (ext)`: Agentの自律実行で機能拡張を変更すべきではないので


### 定期的な見直し

- Claude Codeの開発速度が速く、sandbox周りの仕様は頻繁に変わりうる
- アップデート後に意図通り動作しているか定期的に確認する
- 特にallow/denyルールの記法やsandboxの適用範囲は変更が入りやすい
