# 万葉課題

**テーブルスキーマ（モデル名、カラム名、データ型）を記入**
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

