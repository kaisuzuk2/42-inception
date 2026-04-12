# 環境構築
## 前提条件

- Dockerをインストールする。インストール方法は[こちら](https://docs.docker.com/engine/install/ubuntu/)
- makeコマンドをインストールする

## プロジェクトをクローンする

- git clone \<project\> \<name\>
- cd \<name\>

## secretsフォルダの準備

secretsディレクトリをルートに配置し、以下のファイルを準備する
- secrets/db_password.txt: データベースユーザーのパスワードを記載
- sectets/db_root_password.txt: データベースrootのパスワードを記載
- secrets/credentials.txt: Wordpressの管理者・一般ユーザ情報を記載
### secrets/credentials.txtのフォーマット

- WP_ADMIN_USER=管理者ユーザー名（admin禁止）
- WP_ADMIN_PASSWORD=管理者パスワード
- WP_ADMIN_EMAIL=管理者メールアドレス
- WP_USER=一般ユーザー名
- WP_USER_EMAIL=一般ユーザーメールアドレス
- WP_USER_PASS=一般ユーザーパスワード

## /etc/hostsの設定

127.0.0.1 'login'.42.fr

# ビルドと実行

## 起動

*make* <br>
以下の処理が実行される: 
1. データディレクトリの作成(~/data/mariadb, ~/data/wordpress)
2. Dockerイメージのビルド
3. コンテナの起動

## 停止

- *make down*: コンテナを停止
- *make clean*: コンテナ・イメージ・未使用データを削除
- *make fclean*: 未使用のNamed Volume含めて全て削除

# 運用コマンド

## コンテナの管理

### コンテナの状態確認

docker ps

### コンテナのログ確認

docker compose -f srcs/docker-compose.yml logs

### 特定のコンテナのログ確認

- docker compose -f srcs/docker-compose.yml logs nginx
- docker compose -f srcs/docker-compose.yml logs wordpress
- docker compose -f srcs/docker-compose.yml logs mariadb

### コンテナの中に入る

- docker exec -it nginx bash
- docker exec -it wordpress bash
- docker exec -it mariadb bash

### コンテナの詳細確認

- docker inspect mariadb
- docker inspect wordpress
- docker inspect nginx

## ボリュームの管理

### ボリュームの一覧

docker volume ls

### ボリュームの詳細確認

docker volume inspect srcs_mariadb_data
docker volume inspect srcs_wordpress_data

## ネットワークの管理

### ネットワークの一覧

docker network ls

### ネットワークの詳細確認

docker network inspect srcs_inception

# データ管理

## データの保存場所
| サービス | コンテナ内のパス | ホスト側のパス |
|---------|---------------|--------------|
| MariaDB | /var/lib/mysql | ~/data/mariadb |
| WordPress | /var/www/html | ~/data/wordpress |

## データの永続化
- Named Volumeを使用してデータを永続化している
- コンテナを停止・削除してもデータは保持される

