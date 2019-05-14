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

