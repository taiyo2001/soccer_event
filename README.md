# README

### プロジェクト概要
---
みんサカ - みんなでサッカー！

サッカー掲示板で仲良くなって一緒にサッカーしよう

### 技術選定.etc
---


### LocalのDev環境構築
---
`.tool-versions` or `.ruby-version` を確認して、rubyをセットアップ後

Build
```
bundle && rails db:migrate:reset && rails db:seed
```

Server Up
(立ち上げと同時にtailwindcssの変更もwatchさせるなら`$ bin/dev`だがコンソールに打つデバッグ(byebug.etc)がしづらい)
```
rails s
```

### ログイン情報
---
|  | email | password |
| :--- | :---: | ---: |
| test user | soccersample@example.com | password |
| other user(n<sup>※</sup>) | sample#{n}@example.com | password |

※nは1~50

### デプロイ
---

flyioにデプロイしている

Deploy
```
fly deploy
```

Open app
```
fly app open
```

Ssh
```
fly ssh console
```

Connect DB
```
flyctl postgres connect -a ${app_name}
```

その他各種コマンド
https://fly.io/docs/flyctl/
