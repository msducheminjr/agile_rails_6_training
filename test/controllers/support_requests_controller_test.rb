require 'test_helper'

class SupportRequestsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get support_requests_url
    assert_response :success
  end

  test "should update with rich text response" do
    support_request = support_requests(:ghost_pirates)
    assert_nil support_request.response
    rich_text_body = "<div>That is <em>tragic</em>. We have updated your address in our system.</div>"
    assert_difference ActionMailer::Base.deliveries do
      patch support_request_url(support_request), params: { support_request: { response: rich_text_body} }
    end
    assert_redirected_to support_requests_url
    support_request.reload
    assert_equal  rich_text_body, support_request.response.body.to_trix_html
  end
end