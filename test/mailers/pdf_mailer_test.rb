require "test_helper"

class PdfMailerTest < ActionMailer::TestCase
  test "post_appointment" do
    mail = PdfMailer.post_appointment
    assert_equal "Post appointment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
