# User level CLAUDE.md

## Sandboxの書き込み制限について

sandboxによりプロジェクト外のディレクトリに対する書き込み制限あり。例えばユーザのホームディレクトリにキャッシュを作るコマンドがエラーになる。この問題に遭遇した場合、別のディレクトリを使うなどの回避策を試みるより、一旦作業を中断して、sandboxのallowWriteにパスを追加する、あるいは設定でカレントディレクトリ以下にキャッシュを作るように変更するといった、よりシンプルな対策がないか検討してユーザに提案する


## sandbox除外コマンドのループ構文の注意

gh, bq, gcloud, docker コマンドはユーザレベルのsettings.jsonでsandboxから除外されている。

ただし呼び出し方によってsandbox内から実行される。コマンド置換、サブシェル、ifやforなどの制御構文を含む、ディレクトリ移動を含む `cd ... && gh ...` 、パイプやリダイレクトを含む `docker ps | head`, `docker build . > build.log`、これらはsandbox内での実行になります。

sandbox除外コマンドでエラーが出るときは呼び出しの形を疑ってください。呼び出しからこれらの形を除けるかどうか検討してください。

ghはサブコマンドごとにallow, denyが設定されているため、sandbox外でも失敗することがあります。ext, codespace, csはdenyです。prはmerge、closeなどPRを編集するものがdenyです
