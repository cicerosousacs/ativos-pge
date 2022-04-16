require 'test_helper'

class AtivoPge::SubareasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_subareas_index_url
    assert_response :success
  end

end
