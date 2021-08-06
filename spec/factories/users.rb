FactoryBot.define do
  factory :user do
    name { 'test_user_01' }
    email { 'test_user_01@test.com' }
    password { '12345678' }
    admin { false }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
  end
  factory :second_user, class: User do
    name { 'test_user_02' }
    email { 'test_user_02@test.com' }
    password { '87654321' }
    admin { true }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test2.jpg'))}
  end
end
