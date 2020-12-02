#!/bin/bash
# railsアプリケーションの作成
docker-compose run --rm web rails new . --force --no-deps --database=postgresql --skip-bundle

# railsに必要なgemのファイルができるので、buildをする
# buildをすると、Gemfileに書かれたgemがコンテナ内にinstallされた状態でimageとして保存される
docker-compose build

# TODO:
# /config/database.ymlへの書き換え処理
# host: db
# username: postgres
# password: postgres
# pool: 5
# /Gemfileにデバッグ系gemファイルを追加する処理
# # for debug
# gem 'ruby-debug-ide'
# gem 'debase'

# webpackerのinstall処理
docker-compose run web bundle exec rails webpacker:install

# db作成
docker-compose run web rails db:create

# コンテナ起動
docker-compose up
# background起動したい場合
#docker-compose up -d

# !!!やり直し系コマンド!!!
# 同しようもない場合はcloneし直したほうが早いかも
# docker-compose down --rmi all --volumes --remove-orphans
# git clean -fdx
# git reset --hard HEAD
