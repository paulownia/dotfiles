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

sandboxはBashツールとそのサブプロセスに対する制限

- 常に有効化(`enable: true`)
- `autoAllowBashIfSandboxed`をtrueに設定し、許可なしでコマンドを実行可能にする
- `allowUnsandboxedCommands`をfalseに設定し、sandbox外でのコマンド実行を防止する

sandboxの制限は

- コマンドによる書き込みは、プロジェクト内であれば許可、プロジェクト外はエラー
- コマンドによる読み込みは、ファイルシステム全体で許可

主に読み込みをカスタマイズして、機密ファイルが読まれるのを防止するのが主眼となる。

### filesystem.allowWrite

例えば、claude codeからnpm iなどを実行する場合、~/.npmを追加する必要があるかもしれない。これはNodeプロジェクト固有なのでプロジェクトレベルで有効にすること

### filesystem.denyRead

permissions.denyの指定と同じパスが拒否されるように指定。

## 注意点

### sandbox制限の挙動差異

- Bashツールはsandbox（bwrap/sandbox-exec）内で実行されるため、`denyWithinAllow` 等のファイルシステム制限が適用される
- Write/Edit/Read/Glob等の組み込みツールはClaude Codeプロセス自身が直接操作するため、sandbox制限を受けない
- この挙動差異は将来のアップデートで変更される可能性が高い。sandbox制限に依存したワークアラウンドは避けること

### 定期的な見直し

- Claude Codeの開発速度が速く、sandbox周りの仕様は頻繁に変わりうる
- アップデート後に意図通り動作しているか定期的に確認する
- 特にallow/denyルールの記法やsandboxの適用範囲は変更が入りやすい
