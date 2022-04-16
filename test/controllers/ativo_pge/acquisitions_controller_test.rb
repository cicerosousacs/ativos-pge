require 'test_helper'

class AtivoPge::AcquisitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ativo_pge_acquisitions_index_url
    assert_response :success
  end

end
