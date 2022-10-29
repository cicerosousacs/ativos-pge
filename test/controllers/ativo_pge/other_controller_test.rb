require 'test_helper'

class AtivoPge::OtherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_other_index_url
    assert_response :success
  end

end
