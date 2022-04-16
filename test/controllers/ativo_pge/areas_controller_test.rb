require 'test_helper'

class AtivoPge::AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_areas_index_url
    assert_response :success
  end

end
