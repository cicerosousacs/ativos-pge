require 'test_helper'

class AtivoPge::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_welcome_index_url
    assert_response :success
  end

end
