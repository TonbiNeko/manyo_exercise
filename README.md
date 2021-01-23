# 万葉課題

## テーブルスキーマ（モデル名、カラム名、データ型）を記入
<br>
* User model

|  column  |  data  |
| --- | --- |
|  name  |  string  |
|  email  |  text  |
|  password_digest  |  text  |
<br>

* Task model

|  column  |  data  |
| --- | --- |
|  name  |  string  |
|  description  |  text  |
|  expiration_date  |  datetime  |
|  priority  |  integer  |
|  status  |  string  |
|  user  |  references  |
<br>

* Label model

|  column  |  data  |
| --- | --- |
|  type  |  string  |
|  task  |  references  |

<br>

## heroku デプロイ手順  
**環境**  
Ruby 2.6.5  
Ruby on Rails 5.2.4  
PostgreSQL

<br>

1. herokuにログイン  
コマンド：$ heroku login

2. アセットプリコンパイルをする  
コマンド：$ rails assets:precompile RAILS_ENV=production

3. git add と gitコミットを行う

4. Herokuに新しいアプリケーションを作成  
コマンド：$ heroku create

5. Heroku stackを変更する
(Ruby2.6.5の場合)  
コマンド：$ heroku stack:set heroku-18  
stackバージョン確認のコマンド：$ heroku stack

6. Heroku buildpackを追加  
コマンド：$ heroku buildpacks:set heroku/ruby  
コマンド：$ heroku buildpacks:add --index 1 heroku/nodejs

7. Herokuにデプロイ  
コマンド：$ git push heroku master

8. データベースの移行  
コマンド：$ heroku run rails db:migrate

9. アプリケーションにアクセス  
コマンド：$ heroku open