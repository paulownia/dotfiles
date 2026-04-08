# dotfiles

## Overview

macOS向けの個人dotfilesリポジトリ。Linuxでも使用可能。

## 前提

`~/.dotfiles` にクローンされている想定

## セットアップ

`README.md` を参照。

## 対応OS

macOS/Linux。

コマンドやzsh関数にmacOS固有の機能を使用するスクリプトがある。これらをLinuxで実行した場合はエラーメッセージを出して終了する方針。


## ディレクトリ構成:

- **`CLAUDE.md`** — このファイル
- `README.md` — リポジトリの概要と使用方法
- `README.nvim.md` — Neovim設定の詳細
- `README.claude.md` - Claude Code設定の詳細と方針
- `setup.sh` — 初期セットアップスクリプト。シンボリックリンクの作成や必要なディレクトリの作成を行う。繰り返し実行可能。
- **`dots/`** — ホームディレクトリにリンクされるドットファイル群（`dots/zshrc` → `~/.zshrc` 等）
- **`claude/`** — `~/.claude/` 以下にリンクされるClaude Code設定（CLAUDE.md, settings.json等）
- **`config/`** — `~/.config/` 以下にリンクされるXDG設定（nvim, yamllint）
- **`bin/`** — PATHに追加されるユーティリティスクリプト群。.zprofileで`~/.dotfiles/bin/` がPATHに追加される。
- **`zsh/`** — Zsh autoload関数、補完定義。.zshrcで`~/.dotfiles/zsh/` がfpathに追加される。

### 前提コマンド類

binやzsh以下のツール・関数は次のコマンドの存在が前提となる。インストールされていない場合はエラーメッセージを出して終了する方針

- git
- jq
- fzf
- nvim

