require 'grape'

class MyAPI < Grape::API
  get 'hello' do
    { :hello => 'world' }
  end
end
