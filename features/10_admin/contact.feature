# language:ja

# order: 20
機能: 問い合わせ管理
  管理者として
  問い合わせ状況を管理がしたい
  なぜならサービスを保守運用する必要があるからだ

  シナリオアウトライン: お問い合わせ内容の確認
    前提 問い合わせテーブルが存在する
    前提 問い合わせ内容が登録されている
    前提 管理画面にログインしている
    もし お問い合わせページに移動している
    ならば お問い合わせ内容"<name>","<email>","<questionnaire>","<category>","<message>"が表示される
    例:
      |name     | email | questionnaire | category   | message |
      |お名前    | mail@test.com | answer1 | category1 | メッセージ   |

