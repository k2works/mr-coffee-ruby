
前提(/^問い合わせテーブルが存在しない$/) do
  login
  system_page
  click_button '削除'
end

前提(/^問い合わせテーブルが存在する$/) do
  login
  system_page
  click_button '作成'
  sleep 1
end

前提(/^システムページに移動している$/) do
  system_page
end

もし(/^問い合わせテーブルを作成したら$/) do
  click_button '作成'
end

もし(/^問い合わせテーブルを削除したら$/) do
  click_button '削除'
end

def system_page
  visit '/admin-system'
end
