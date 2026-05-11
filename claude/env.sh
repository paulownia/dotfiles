#!/bin/bash
#
# claude codeは起動時に.zshrcを読み込むが、PATHの変更が反映されないことがある。
# rbenv initは全く反映されない、nvmは反映される場合がある、Google Cloud SDKはほぼ反映される。
# 確実にPATHが通るように、このスクリプトでnvmとrbenvのパスを直接設定する。
#
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
