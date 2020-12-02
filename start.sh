#!/bin/bash
# railsアプリケーションの作成
docker-compose run --rm web rails new . --force --no-deps --database=postgresql --skip-bundle

# /config/database.ymlへの書き換え処理
# host: db
# username: postgres
# password: postgres
# pool: 5
sed -ie '20,22d' config/database.yml && sed -ie '20i  \ \ host: db\n\ \ username: postgres\n\ \ password: postgres\n\ \ pool: 5' config/database.yml

# /Gemfileにデバッグ系gemファイルを追加する処理
# # for debug
# gem 'ruby-debug-ide'
# gem 'debase'
sed -ie "43i  \ \ # for debug\n\ \ gem 'ruby-debug-ide'\n\ \ gem 'debase'" Gemfile

# railsに必要なgemのファイルができるので、buildをする
# buildをすると、Gemfileに書かれたgemがコンテナ内にinstallされた状態でimageとして保存される
docker-compose build

# webpackerのinstall処理
docker-compose run --rm web bundle exec rails webpacker:install

# db作成
docker-compose run --rm web rails db:create

# コンテナ起動
docker-compose up
# background起動したい場合
#docker-compose up -d

# !!!やり直し系コマンド!!!
# どうしようもない場合はcloneし直したほうが早いかも
# docker-compose down --rmi all --volumes --remove-orphans
# git clean -fdx
# git reset --hard HEAD
