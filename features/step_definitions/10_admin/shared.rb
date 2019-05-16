# frozen_string_literal: true

もし(/^ダッシュボードのナビゲーションの"([^"]*)"をクリックしたならば$/) do |link|
  case link
  when 'Dashboard'
    find('#accordionSidebar > li.nav-item.active > a > span').click
  when 'Contact'
    find('#accordionSidebar > li:nth-child(6) > a > span').click
  when 'System'
    find('#accordionSidebar > li:nth-child(7) > a > span').click
  end
end

def login
  visit '/admin-login'
  fill_in 'exampleInputEmail', with: 'test@test.com'
  fill_in 'exampleInputPassword', with: 'password'
  click_on 'Login'
end

def logout
  find('#userDropdown > img').click
  find('#content > nav > ul > li.nav-item.dropdown.no-arrow.show > div > a:nth-child(5)').click
  click_on 'Logout'
end
