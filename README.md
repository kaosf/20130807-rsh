# 2013-08-07 Rails で scaffold な Heroku 勉強会 in 徳島 成果物

以下に記す手順を踏んで作られたものがこのリポジトリそのものであると考えてくれていい．

`myfirstapp` や `myname` と言ったものは適宜置き換え，読み替えをされたし．

## 手順メモ

* Git をインストールしてユーザ名とメールアドレスの設定，公開鍵の作成を終えておく
* Ruby をインストールする (特に理由がなければ 2.0.0 の最新のもので)
* Rails をインストールする
  * `gem installl rails --no-ri --no-rdoc`
* SQLite3 と PostgreSQL の開発用パッケージをインストールする
  * `sudo apt-get install libsqlite3-dev postgresql-server-dev-9.1`
    * `sudo apt-get install sqlite3` が必要だったかどうか忘れた (とりあえず入れておこう)
  * ここ Mac の人はどうするんだっけか…
* Rails アプリを作る
  * `rails new myfirstapp`
* ※以下の作業工程を全て Git の commit として残しておくと後から復習しやすくて良いと思います
* production 環境では PostgreSQL を使うようにする (※ガチでやるなら development も test も PostgreSQL に揃えるべし)
  * `Gemfile` を以下のように書き換え

```diff
-gem 'sqlite3'
+group :development, :test do
+  gem 'sqlite3'
+end
+group :production do
+  gem 'pg'
+end
```

* `bundle install` で `Gemfile.lock` も更新
* `rails g scaffold item name:string` をしてみる (アプリの機能の土台というか割と至れり築くせりな雛形作成)
  * `item name:string` の部分はもし分かるなら自分で好きなようにしてみよう
* `rake db:migrate` をしてみる (DB の schema を更新)
* `rails server` ないし `rails s` でサーバとしてプログラムを走らせておいて Web ブラウザで http://localhost:3000/items にアクセスしてみる (きっと嬉しいことになってる)
  * もういいやと思ったら C-c でプロセスを殺しましょう
* Heroku のアカウント作成
* Heroku Toolbelt をインストール
  * [Heroku Toolbelt](https://toolbelt.heroku.com/)
* `heroku login` でログイン
  * このとき公開鍵があるなら Heroku 側に送られる
  * 後から公開鍵を作った場合は `heroku keys:add` で送ることが出来る
* `heroku apps:create myname-myfirstapp` 等として Heroku にアプリの土台となる環境を作成
  * `myname-` みたいな prefix を付けておくのはバッティングを防止するため (ダブらない自信があるなら何でもいい)
  * アプリ名を省略すると Heroku 側で勝手に適当な (本当に適当なので注意) 名前を付けてもらえる (後から rename も一応出来る)
  * Git のリポジトリとして Rails のプロジェクトが管理されているならこの時点で remote repository に heroku が登録される
  * 後からリモートリポジトリを追加する場合は URL を `git@heroku.com:myname-myfirstapp.git` とする
* `git push heroku master` で deploy
* `heroku run rake db:migrate` で Heroku 側の DB の schema も更新
* Web ブラウザで http://myname-myfirstapp.herokuapp.com/items にアクセスしてみる (きっとローカルで見たのと同じ景色が)

## 備考

実際の Heroku 上のサンプル: http://ka-20130807-rsh.herokuapp.com/items

※URL から items を除いて / に直接アクセスするとルーティングの設定不足によりエラーになる

"rsh" とは "Rails で scaffold な Heroku" の頭文字のつもり

Rails プロジェクト自体は `rails new ka-heroku-test` で作った

## Contributing

1. Fork it and clone it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## 貢献する方法

1. フォークしてクローンします
2. 新機能用のブランチを作ります (`git checkout -b my-new-feature`)
3. あなたが行った変更をコミットします (`git commit -am 'Add some feature'`)
4. リモートのブランチにプッシュします (`git push origin my-new-feature`)
5. 新規プルリクエストを作って下さい
