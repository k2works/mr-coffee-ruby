# language:ja

機能: テーブル管理
  管理者として
  テーブルの管理がしたい
  なぜならサービスを保守運用する必要があるからだ

  シナリオ: 問い合わせテーブルの作成
    前提 問い合わせテーブルが存在しない
    前提 管理画面にログインしている
    前提 システムページに移動している
    もし 問い合わせテーブルを作成したら
    ならば "問い合わせテーブルを作成しました"が表示される

  シナリオ: 問い合わせテーブルの削除
    前提 問い合わせテーブルが存在する
    前提 管理画面にログインしている
    前提 システムページに移動している
    もし 問い合わせテーブルを削除したら
    ならば "問い合わせテーブルを削除しました"が表示される
