require 'test_helper'

class AtivoPge::DepositsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_deposits_index_url
    assert_response :success
  end

end
