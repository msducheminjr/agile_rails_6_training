require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:daves))
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    assert_equal ['dave@wendys.example.com'], mail.to
    assert_equal ['statelesscode@example.com'], mail.from
    assert_match /Thank you for your recent order from The Pragmatic Store/, mail.body.encoded
    assert_no_match /This is just to let you know that we've shipped your recent order/, mail.body.encoded
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
    assert_match /<td[^>]*>1<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:daves))
    assert_equal 'Pragmatic Store Order Shipped', mail.subject
    assert_equal ['dave@wendys.example.com'], mail.to
    assert_equal ['statelesscode@example.com'], mail.from
    assert_match /This is just to let you know that we've shipped your recent order/, mail.body.encoded
    assert_no_match /Thank you for your recent order from The Pragmatic Store/, mail.body.encoded
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
    assert_match /<td[^>]*>1<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
