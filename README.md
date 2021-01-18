# 万葉課題

**テーブルスキーマ（モデル名、カラム名、データ型）を記入**

1. Task model
  * name : string
  * description : text
  * expiration_date : datetime
  * priority : integer
  * status : string
  * user : references
<br>
2. User model
  * name : string
  * email : text
  * password_digest : text
<br>
3. Label model
  * type : string
  * task : references
