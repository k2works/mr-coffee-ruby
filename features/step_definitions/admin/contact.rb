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
