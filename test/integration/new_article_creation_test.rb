require 'test_helper'

class NewArticleCreationTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password")
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success

    post articles_path, params: { article: { title: "12345678", description: "lalalalala", categories_ids: "Sports"} }
    puts response.body
    assert_response :redirect

    follow_redirect!
    assert_response :success
    assert_match "12345678", response.body
  end

end
