require 'test_helper'

class AtivoPge::AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_admins_index_url
    assert_response :success
  end

end
