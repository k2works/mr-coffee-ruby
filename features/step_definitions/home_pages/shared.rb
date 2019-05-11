# frozen_string_literal: true

前提(/^"([^"]*)"にアクセスしている$/) do |url|
  visit url
end

もし(/^"([^"]*)"にアクセスした$/) do |url|
  visit url
end

もし(/^ナビゲーションの"([^"]*)"をクリックしたならば$/) do |link|
  case link
  when 'Top'
    find('#navbar-content > ul.navbar-nav.mr-auto > li.nav-item.active > a').click
  when 'About'
    find('#navbar-content > ul.navbar-nav.mr-auto > li:nth-child(2) > a').click
  when 'Menu'
    find('#navbar-content > ul.navbar-nav.mr-auto > li:nth-child(3) > a').click
  when 'Coupon'
    find('#navbar-content > ul.navbar-nav.mr-auto > li:nth-child(4) > a').click
  when 'Shop'
    find('#navbarDropdown').click
    find('#navbar-content > ul.navbar-nav.mr-auto > li.nav-item.dropdown.show > div > a:nth-child(1)').click
  when 'Access'
    find('#navbarDropdown').click
    find('#navbar-content > ul.navbar-nav.mr-auto > li.nav-item.dropdown.show > div > a:nth-child(2)').click
  end
end

もし(/^フッターの"([^"]*)"をクリックしたならば$/) do |link|
  case link
  when 'Top'
    find('body > footer > div > ul > li:nth-child(1) > a').click
  when 'News'
    find('body > footer > div > ul > li:nth-child(2) > a').click
  when 'About'
    find('body > footer > div > ul > li:nth-child(3) > a').click
  when 'Menu'
    find('body > footer > div > ul > li:nth-child(4) > a').click
  when 'Coupon'
    find('body > footer > div > ul > li:nth-child(5) > a').click
  when 'Information'
    find('body > footer > div > ul > li:nth-child(6) > a').click
  when 'Contact'
    find('body > footer > div > ul > li:nth-child(7) > a').click
  end
end

ならば(/^"([^"]*)"が表示される$/) do |content|
  expect(page).to have_content content
end

