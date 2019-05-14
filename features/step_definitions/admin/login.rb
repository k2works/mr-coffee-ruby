もし(/^管理画面にログインしている$/) do
  login
end

def login
  visit '/admin-login'
  fill_in 'exampleInputEmail', with: 'test@test.com'
  fill_in 'exampleInputPassword', with: 'password'
  click_on 'Login'
end
