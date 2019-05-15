前提(/^問い合わせ内容が登録されている$/) do
  visit '/contact'

  fill_in 'name', with: 'お名前'
  fill_in 'email', with: 'mail@test.com'
  choose '口コミ'
  select 'ご予約について', from: 'category'
  fill_in 'message', with: "メッセージ"

  click_button '確認する'
end

前提(/^お問い合わせページに移動している$/) do
  visit '/admin-contact'
end

ならば(/^お問い合わせ一覧に"([^"]*)"が表示される$/) do |content|
  expect(page).to have_content content
end

ならば(/^お問い合わせ内容"([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"が表示される$/) do
   |name,
    email,
    questionnaire,
    category,
    message|

  expect(page).to have_content name
  expect(page).to have_content email
  expect(page).to have_content questionnaire
  expect(page).to have_content category
  expect(page).to have_content message
end
