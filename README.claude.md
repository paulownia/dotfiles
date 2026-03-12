# Claude Code 設定ガイド

`claude/settings.json` の編集方針をまとめる。

## パーミッション設定の方針

### defaultMode

`"default"` を使用する。allow/denyに含まれないツール呼び出しは都度ユーザーに確認が入る。

### allow（ホワイトリスト）

- 副作用のない読み取り系ツールのみ許可する
- `Grep`, `Glob`, 読み取り専用のgitコマンド、`ls`, `which` など
- `Read` は allow に入れない。allow にすると deny に入っていない機密ファイルが確認なしで読めてしまうため
- 言語・フレームワーク固有のコマンド（npm, node等）はグローバルに追加せず、プロジェクト単位の設定で対応する

### deny（ブロックリスト）

- 確認プロンプトすら出さずに即ブロックする（多層防御）
- `defaultMode: "default"` で一次防御はあるが、うっかり許可してしまうリスクを防ぐ
- 対象: 認証情報・秘密鍵など、誤って読まれると致命的なファイル
  - `.env*` — 環境変数・シークレット
  - `.ssh/` — SSH鍵・設定
- `Read`, `Bash` でブロックする

### 優先順位

deny > allow > defaultMode の順で評価される。

## 注意点

### sandbox制限の挙動差異

- Bashツールはsandbox（bwrap/sandbox-exec）内で実行されるため、`denyWithinAllow` 等のファイルシステム制限が適用される
- Write/Edit/Read/Glob等の組み込みツールはClaude Codeプロセス自身が直接操作するため、sandbox制限を受けない
- この挙動差異は将来のアップデートで変更される可能性が高い。sandbox制限に依存したワークアラウンドは避けること

### 定期的な見直し

- Claude Codeの開発速度が速く、sandbox周りの仕様は頻繁に変わりうる
- アップデート後に意図通り動作しているか定期的に確認する
- 特にallow/denyルールの記法やsandboxの適用範囲は変更が入りやすい
