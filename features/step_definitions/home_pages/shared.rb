# frozen_string_literal: true

もし(/^"([^"]*)"にアクセスした$/) do |path|
  visit path
end

ならば(/^"([^"]*)"が表示される$/) do |content|
  expect(page).to have_content content
end
