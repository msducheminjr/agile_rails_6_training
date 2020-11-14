class SupportMailbox < ApplicationMailbox
  def process
    puts 'START SuppportMailbox#process:'
    puts "From   : #{mail.from_address}"
    puts "Subject: #{mail.subject}"
    puts "Body   : #{mail.body}"
    puts 'END SuppportMailbox#process:'
  end
end
