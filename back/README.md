# terraform-python-sample/back

ServerlessFramework を使用した Lambda のローカルデバッグ方法

# Requirement

## OS

Mac か Ubuntu を利用してください

### Windows 環境の場合

- WSL
  - ディストリービューションは`Ubuntu`を使用すること

## aws

```bash
$ aws --version
aws-cli/2.2.25 Python/3.8.8 Darwin/21.5.0 exe/x86_64 prompt/off
```

## asdf

```bash
asdf --version
v0.10.2
```

## node.js

```bash
$ node --version
Python 3.10.3
```

## python

```bash
$ python --version
Python 3.10.3
```

# Installation

すでにインストールされているツールはスキップしてください

## asdf をインストール

Google 等で OS に合った方法を検索しインストール

例：Ubuntu
https://qiita.com/salty-byte/items/e6fe2bbc748dff15de34

## AWS CLI

### AWS CLI をインストール

https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html

### IAM の設定

```bash
$ aws configure
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

## node.js

```bash
# プラグインをインストール
$ sudo -i asdf plugin add nodejs

# インストール可能なバージョンの確認
$ sudo -i asdf list-all nodejs

# バージョンを指定してインストール
$ sudo -i asdf install nodejs 18.7.0

# バージョンを指定して適用
$ sudo -i asdf global nodejs 18.7.0

# バージョン確認
$ node -v
```

## serverless framework

```bash
$ sudo -i npm install -g serverless
```

## python

```bash
# 事前準備（依存ファイルのインストール）
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev

# プラグインをインストール
$ sudo -i asdf plugin add python

# インストール可能なバージョンの確認
$ sudo -i asdf list-all python

# バージョンを指定してインストール
$ sudo -i asdf install python 3.10.3

# バージョンを指定して適用
$ sudo -i asdf global python 3.10.3

# バージョン確認
python -V
```

# 初期設定

```bash
$ npm install
```

# ローカルデバッグ

## serverless-offline の起動

```bash
$ serverless offline
```
