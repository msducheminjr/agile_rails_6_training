require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "we create a SupportRequest when we get a support email" do
    receive_inbound_email_from_mail(
      to: 'support@example.com',
      from: 'chris@somewhere.net',
      subject: 'Need help',
      body: "I can't figure out how to check out!!"
    )

    support_request = SupportRequest.last
    assert_equal 'chris@somewhere.net', support_request.email
    assert_equal 'Need help', support_request.subject
    assert_equal "I can't figure out how to check out!!", support_request.body
    assert_nil support_request.order
  end

  test "we create a SupportRequest with the most recent order" do
    recent_order = orders(:frodos_new)
    older_order = orders(:frodos_old)
    non_customer = orders(:daves)

    receive_inbound_email_from_mail(
      to: 'support@example.com',
      from: recent_order.email,
      subject: 'Misdelivered',
      body: "My order was sent to the Sackville Bagginses and they won't give it to me."
    )

    support_request = SupportRequest.last
    assert_equal recent_order.email, support_request.email
    assert_equal 'Misdelivered', support_request.subject
    assert_equal(
      "My order was sent to the Sackville Bagginses and they won't give it to me.",
      support_request.body
    )
    assert_equal recent_order, support_request.order
  end
end
