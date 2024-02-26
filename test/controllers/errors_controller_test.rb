require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def not_found
    render status: 404
  end
 
  def internal_server
    render status: 500
  end
 
  def unprocessable
    render status: 422
  end
 
  def unacceptable
    render status: 406
  end
end
