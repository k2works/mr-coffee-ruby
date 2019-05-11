# frozen_string_literal: true

もし(/^お問い合わせフォームに必要事項を入力して$/) do
  fill_in 'name', with: 'お名前'
  fill_in 'email', with: 'mail@hoge.com'
  choose '口コミ'
  select 'ご予約について', from: 'category'
  fill_in 'message', with: "あああ\nいいい\nううう"
end

かつ(/^送信ボタンを押した$/) do
  click_button '確認する'
end
