# frozen_string_literal: true

もし(/^お問い合わせ内容"([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"を入力して$/) do |name, email, questionnaire, category, message|
  fill_in 'name', with: name
  fill_in 'email', with: email
  choose questionnaire
  select category, from: 'category'
  fill_in 'message', with: message
end

かつ(/^送信ボタンを押した$/) do
  click_button '確認する'
end
