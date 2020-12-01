#!/bin/bash
# エラー時にスクリプトを止める
# https://qiita.com/youcune/items/fcfb4ad3d7c1edf9dc96
set -e

# Remove a potentially pre-existing server.pid for Rails.
# pidファイルはサーバーが起動しているかどうかをsystemd側から判断するためのもの
# 中にはプロセス番号が記載されている
# コンテナを再起動した際に存在しているとサーバーが起動できなくなるので削除する
rm -f /food_display/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"