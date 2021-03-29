#リポジトリとタグ
FROM ruby:2.4.5

#コンテナを起動してコンテナ内で実行する命令
#ubuntuのパッケージ管理システムのapt-getでbuild-essential nodejsをインストールしている(Railsには必須)
RUN apt-get update -qq && apt-get install -y build-essential nodejs

#ルートディレクトリ内にappディレクトリを作成。この中にRailsのプロジェクトを作成する
RUN mkdir /app

#作業ディレクトリを/appに変更
WORKDIR /app

#Gemfileを/app内にコピーしている。最初にGemfileにRailsのバージョンを記載してからbundle installする
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

#Dockerファイルの置いてあるフォルダの内容を全てコンテナ内のappディレクトリにコピーしている
#Railsの必要なファイルを全てコピーするため。余計なファイルは置かないようにする
COPY . /app
