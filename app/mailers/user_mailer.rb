class UserMailer < ApplicationMailer

  # What's this? Is this the 寄件人？
  default from: "My Cart <info@aplphacamp.co>"

  # Welcome the user by ActiveMailer
  # It's worked by devise.

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to The Wall Indie')
  end

  # # When there has new evnet of some artist, notice the fans!
  # # connect with event#create
  # # testA
  # def artist_new_evnet(event)
  #   @event = event
  #   mail( to: @event.users.email),
  #    subject: '#{@artist.name} arranged NEW event #{@event.name}' )
  # end
  # # testB
  # def recent_artist_event(user, artist, event)
  #   @artist = artist
  #   @event = event
  #   mail(to: user.email, subject: "New event of #{artist}")
  # end

  # # The event will arrange in a week, don't forget the show!
  # def week_before_event(user)
  #   @user = user
  #   @content = "Your order is created. Thank you!"

  #   mail to: order.user.email,
  #   subject: "ALPHA Camp | 訂單成立: #{@order.id}"
  # end

  
end
