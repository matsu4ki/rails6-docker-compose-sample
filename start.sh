#!/bin/bash
# railsアプリケーションの作成
docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle

# railsファイルが作成されるので、
docker-compose build


# !!!やり直し系コマンド!!!
# 同しようもない場合はcloneし直したほうが早いかも
# docker-compose down --rmi all --volumes --remove-orphans
# git clean -fdx
# git reset --hard HEAD
