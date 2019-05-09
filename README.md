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
pip install --user aws-sam-cli
pip install --user --upgrade aws-sam-cli
 ```
 
 ```bash
sam init --runtime ruby2.5 -n src
 ```
 
 
**[⬆ back to top](#構成)**

### 配置

**[⬆ back to top](#構成)**

### 運用

**[⬆ back to top](#構成)**
