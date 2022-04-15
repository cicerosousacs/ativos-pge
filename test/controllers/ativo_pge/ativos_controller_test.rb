require 'test_helper'

class AtivoPge::AtivosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_ativos_index_url
    assert_response :success
  end

end
