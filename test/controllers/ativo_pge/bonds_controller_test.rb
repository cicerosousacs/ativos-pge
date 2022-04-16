require 'test_helper'

class AtivoPge::BondsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_bonds_index_url
    assert_response :success
  end

end
