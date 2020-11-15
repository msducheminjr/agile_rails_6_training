require 'test_helper'

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    mail = SupportRequestMailer.respond(support_requests(:daves))
    assert_equal 'Re: Got Python book by mistake', mail.subject
    assert_equal ['dave@wendys.example.com'], mail.to
    assert_equal ['support@example.com'], mail.from
    assert_equal read_fixture('respond.text').join, mail.text_part.body.to_s
    assert_equal read_fixture('respond.html').join, mail.html_part.body.to_s
  end

end
