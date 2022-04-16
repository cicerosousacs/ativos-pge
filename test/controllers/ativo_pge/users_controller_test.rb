require 'test_helper'

class AtivoPge::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_users_index_url
    assert_response :success
  end

end
