# Mr.M Coffee 

## 概要

### 目的

### 前提

| ソフトウェア   | バージョン | 備考 |
| :------------- | :--------- | :--- |
| ruby           | 2.5.0      |      |
| nodejs         | 8.10.0     |      |
| docker         | 18.09.2    |      |
| docker-compose | 1.23.2     |      |
| aws-cli        | 1.16.127   |      |
| sam-cli        | 0.13.0     |      |

## 構成

- [構築](#構築)
- [配置](#配置)
- [運用](#運用)

## 詳細

### 構築

#### 開発パッケージのセットアップ

```bash
npm init
npm install npm-run-all watch foreman cpx rimraf --save-dev
npm install prettier @prettier/plugin-ruby --save-dev
npm install --save-dev browser-sync connect-browser-sync
npx browser-sync init
touch Procfile
```
#### アプリケーションのセットアップ

AWS SAM CLI のインストールおよびアップデート

 ```bash
pip install --user awscli
pip install --user aws-sam-cli
pip install --user --upgrade aws-sam-cli
 ```
 
 ```bash
gem install bundler -v "~> 1.17"
 ```

lambdaファンクション用バケットのセットアップ

```bash
npm run aws:s3:create
```
 
#### データベースのセットアップ
 
```bash
npm run db:setup
```

**[⬆ back to top](#構成)**

### 配置

#### アプリケーションのデプロイ

```bash
npm run aws:sam:release
```

**[⬆ back to top](#構成)**

### 運用

#### データベースの起動と停止

```bash
npm run db:start
npm run db:show
npm run db:stop
```

#### アプリケーションの廃棄

```bash
npm run aws:sam:destroy
npm run aws:s3:destroy
```

### 開発

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/k2works/mr-coffee-ruby.git)

IDE起動後にコマンドラインで以下のコマンドを実行する
```bash
chmod 0700 ./scripts/setup.sh
./scripts/setup.sh
npm start
```
A service is available on port 3000ポップアップからOpen PreviewまたはOpen Browserを押す

**[⬆ back to top](#構成)**
