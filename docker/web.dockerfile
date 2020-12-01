FROM ruby:2.7.2-slim
# L1: package更新
# L2: postgresql
# L3: gem:nokogiri
# L4: gem:webpacker
RUN apt-get update -qq && apt-get install -y \
libpq-dev postgresql-client \
build-essential patch ruby-dev zlib1g-dev liblzma-dev \
curl

# webpack用のyarnInstall
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y nodejs yarn

# webコンテナ内にアプリ
RUN mkdir rails6-docker-compose-sample
WORKDIR /rails6-docker-compose-sample

# ローカル側のファイルをコピー
COPY Gemfile /rails6-docker-compose-sample/Gemfile
COPY Gemfile.lock /rails6-docker-compose-sample/Gemfile.lock

# gem install
RUN bundle install

COPY . /rails6-docker-compose-sample

# initスクリプト起動
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]
