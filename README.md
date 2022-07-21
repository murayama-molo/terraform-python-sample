# terraform-python-sample

terraform で AWS 環境上に API Gateway, Lambda(python), CloudFront, S3 を作ってみるサンプル

<img width="881" alt="スクリーンショット 2022-07-14 16 52 36" src="https://user-images.githubusercontent.com/21980958/178931198-026c516a-f0bc-4033-970d-97ff0975c2e0.png">

# Requirement

以下の環境で構築しました

## aws

```bash
$ aws --version
aws-cli/1.25.29 Python/3.8.10 Windows/10 exec-env/EC2 botocore/1.27.29
```

## chocolatey

```bash
choco -v
1.1.0
```

## terraform

```bash
$ terraform -v
Terraform v1.2.4
on windows_amd64
```

## git

```bash
$ git -v
git version 2.37.1.windows.1
```

# Installation

すでにインストールされているツールはスキップしてください

## chocolatey

パッケージマネージャー

### chocolatey をインストール

https://chocolatey.org/install#individual

例:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## AWS CLI

### AWS CLI をインストール

https://docs.aws.amazon.com/ja_jp/cli/v1/userguide/install-windows.html#install-msi-on-windows

### IAM の設定

```bash
$ aws configure
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

## terraform

```bash
$ choco install terraform
```

## git

```bash
$ choco install git
```

# ワークスペースの設定

````bash
$ terraform workspace new {ワークスペース名}
$ terraform workspace select {ワークスペース名}
```

# plan

※apply するリソースの確認

```bash
$ terraform plan -var 'profile=default' -var 'domain_name=example.com' -var 'domain_name_certificate_arn=arn:aws:acm:ap-northeast-1:xxxxxxxxxxxx:certificate/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
````

# apply

```bash
$ terraform apply -var 'profile=default' -var 'domain_name=example.com' -var 'domain_name_certificate_arn=arn:aws:acm:ap-northeast-1:xxxxxxxxxxxx:certificate/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
```

# destroy

お掃除
作ったリソースを全部削除

```bash
$ terraform destroy
```

※aws の認証情報をプロファイルで分けている場合は

```bash
$ serverless remove --aws-profile ${自分の設定したプロファイル名}
```
