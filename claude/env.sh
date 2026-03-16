#!/bin/bash
#
# claude codeはzshrcを読み込んでPATHを設定するが、rbenvやnvmを実行して設定したパスが反映されないことがある。
# バージョン2.1.74では反映されたが2.1.76では反映されなかった。
# その対策として、このスクリプトでnvmとrbenvのパスを直接設定する。
# CLAUDE_ENV_FILE 環境変数でこのファイルを指定すると claude code 起動時にこのスクリプトが実行される。
# CLAUDE_ENV_FILE は.zprofile で設定されることを想定している。

# nvm: インストール済みの最新バージョンを使用
nvm_dir=$(printf '%s\n' "$HOME/.nvm/versions/node/v"* | sort -V | tail -1)
if [[ -d $nvm_dir ]]; then
	export CLAUDE_NODE_PATH="$nvm_dir/bin"
	export PATH="$CLAUDE_NODE_PATH:$PATH"
fi

# rbenv shims
if [[ -d "$HOME/.rbenv/shims" ]]; then
	export CLAUDE_RUBY_PATH="$HOME/.rbenv/shims"
	export PATH="$CLAUDE_RUBY_PATH:$PATH"
fi
