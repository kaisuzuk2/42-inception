*This project has been created as part of the 42 curriculum by kaisuzuk*

# プロジェクトの説明 - Description

## 目的
- Dockerとコンテナ化の概念を深く理解する。
- 公式のDocker imageがどのような手順で構築されているのかを理解する。
- NGINX、WordPress、MariaDBなどの各種サービスをゼロから設定する方法を学ぶ。

## 概要
このインフラはDocker Composeで管理される3つのDockerコンテナで構成されています。

### NGINX
- ポート443のみでHTTPS通信を受け付けるwebサーバー
- TLS1.2/TLS1.3のみ対応し、外部から唯一の入り口
- リクエストをWordPressコンテナに転送する

### WordPress + php-fpm
- WordPressのCMSとphp-fpmを組み合わせたアプリケーションサーバー
- NGINXからのリクエストをPHPで処理する
- MariaDBにデータを保存する

### MariaDB
- WordPressのデータを管理するデータベースサーバー

# 手順 - Instructions

## 前提条件　
- dockerをインストールする。手順は[こちら](https://docs.docker.com/engine/install/ubuntu/)
- makeコマンドが使えること

## /etc/hosts/の設定
sudo echo "127.0.0.1 'login.42.fr" >> /etc/hosts

## 起動方法
make

## 停止方法
- コンテナを停止
make down
- コンテナ・イメージを削除
make clean
- 全て(ボリュームも含む)削除
make fclean

## アクセス方法
https://'login'.42.fr

# リソース - Resources
- [dockerdocs](https://docs.docker.com/manuals/)
- [MariaDB document](https://mariadb.com/docs)
- [NGINX document](https://nginx.org/)
- [NGINX config](https://ja.wordpress.org/support/article/nginx/)
- [NGINX conf.d](https://wiki.debian.org/Nginx/DirectoryStructure)
- [WordPress handbook](https://make.wordpress.org/cli/handbook/)
- [php-fpm config](https://zenn.dev/toshi052312/articles/79051f48948d64)
- [SSL/TLS](https://www.youtube.com/watch?v=F3eLZynBDV0)
- [openssl](https://qiita.com/daixque/items/b9432dbf7c344142a72b)

## books
- [開発系エンジニアのためのDocker絵とき入門](https://www.shuwasystem.co.jp/book/9784798071503.html)
- [仕組みと使い方がわかるDocker&Kubernetesのきほんのきほん](https://book.mynavi.jp/ec/products/detail/id=120304)

## AI
- 各docker-entrypoint.shの、シェルスクリプトの文法チェック
- 各configファイルの設定チェック
- 理解度のための壁打ち
- 翻訳

# プロジェクト詳細 - Project description

## Dockerの使用方法
このプロジェクトでは、Docker Composeを使って複数のコンテナを管理しています。
各サービスは独立したコンテナで動作し、Dockerネットワークを通じて通信します。
- **Dockerfile**: 各サービスのイメージをビルドする
- **Docker-Compose.yml**: 複数のコンテナをまとめて管理する
- **Named Volume**: データを永続化する
- **Docker Network**: コンテナ間の通信を管理する
- **Docker Secrets**: パスワードなどの機密情報を安全に管理する

## 主要な設計上の選択
- **ベースイメージ**: Debian Bullseyeを使用(安定版の1つ前のバージョンから)
- **TLS**: 自己署名証明書を使用してHTTPS通信を実現
- **セキュリティ**: パスワードはDocker Secretsで管理し、環境変数には含めない
- **エントリポイント**: 外部からのアクセスはNGINXのポート443のみ
- **コンテナの分離**: それぞれのサービスは独立したコンテナで動作する

## Virtual Machines vs Docker

### virtual Machines 
- ハイパーバイザーを使ってハードウェアを仮想化する
- OSまるごと(カーネル含む)仮想化するため、リソース消費が大きい
- 起動に時間がかかる

### Docker
- ホストOSのカーネルを共有する
- カーネルを持たず、Linux環境のみを持つ
- リソース消費が小さく、起動が速い

## Secrets vs Environment Variables

### Environment Variables
- .envファイル・docker-compose.ymlファイルで設定する
- docker inspectコマンドで値が見える
- 環境変数は全てのコンテナから参照できる

### Secrets
- ファイルとしてコンテナ内の/run/secretsにマウントされる
- docker inspectコマンドで値が見えない
- 必要なコンテナにのみ値を渡すことができる

## Docker Network vs Host Network

### Host Network
- コンテナがホストのネットワークをそのまま使う
- コンテナとホストが同じIPアドレスを持つ
- コンテナ間の隔離がないので、セキュリティ的に危険

### Docker Network
- コンテナごとに独立した仮想ネットワークを作成
- コンテナ同士はコンテナ名でアクセスできる
- 同じネットワーク内のコンテナのみ通信できる

## Docker Volumes vs Bind Mounts

### Bind Mounts
- ホストの特定のディレクトリをコンテナにマウントする
- ホスト側のパスを直接指定する
- Dockerが管理しない

### Docker Volumes
- Dockerが管理する仮想ボリューム
- docker volumeコマンドで管理できる
- ホスト側の保存場所をDockerが管理する