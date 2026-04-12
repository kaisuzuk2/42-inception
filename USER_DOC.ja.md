# 提供されるサービスの説明 -  Understand what services are provided by the stack.
## NGINX
- ポート443でHTTPS通信を受け付けるWebサーバー
- TLS1.2 / TLS1.3のみをサポートし、外部からの唯一のエントリポイント
- リクエストをWordPressコンテナに転送する

## WordPress + php-fpm
- php-fpmを使ってPHPを実行し、動的にwebページを生成する
- 記事・ユーザー情報・設定などをMariaDBデータベースで管理する
- 管理画面からコンテンツの作成・編集が可能

## MariaDB
- WordPressのデータを管理するデータベース
- Named Volumeを使用してデータを永続化する

# 起動・停止方法 - Start and stop the project.
## 起動
make

## 停止
- コンテナの停止: *make down*
- コンテナ・イメージ・その他未使用のデータを削除: *make clean*
- 未使用のNamed Volumeを含めて削除: *make fclean*

# webサイトと管理画面へのアクセス方法 - Access the website and the administration panel.
## webサイトへのアクセス
https://kaisuzuk.42.fr

## 管理画面へのアクセス
https://kaisuzuk.42.fr/wp-admin

# 認証情報の管理 - Locate and manage credentials.
## 認証情報の場所
認証情報は以下のファイルで管理されている: 
- データベースのパスワード: secrets/db_password.txt
- データベースrootのパスワード: secrets/db_root_password.txt
- WordPressの管理者・一般ユーザー情報: secrets/credentials.txt

## 認証情報の変更方法
1. 対象のファイルを編集する
2. コンテナを再起動する

# ステータス確認 - Check that the services are running correctly.
## コンテナの状態確認

*docker ps* <br>
全てのコンテナが'UP'の状態であれば、正常に起動している。

## ログの確認

*docker compose -f srcs/docker-compose.yml logs*

### 特定のコンテナログの確認

- *docker compose -f srcs/docker-compose.yml logs wordpress*
- *docker compose -f srcs/docker-compose.yml logs nginx*
- *docker compose -f srcs/docker-compose.yml logs mariadb*
