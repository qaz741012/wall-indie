# Just do it
class UserMailer < ApplicationMailer
  # What's this? Is this the mailer?
  default from: 'The Wall <postmaster@mg.wallindie.com>'

  # Welcome the user by ActiveMailer
  # It's worked by devise.
  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to The Wall Indie')
  end

  # When there has new evnet of some artist, notice the fans!
  # connect with event#create
  # def artist_new_evnet(user)
  #   @user = user
  #   subject = "#{@artist.name} arranged NEW event #{@event.name}"
  #   mail to: @user.email, subject: subject
  # end

  # when you followed event your friend will go with you!
  # def friend_notice(user)
  #   @user = user
  #   subject = "#{@user.name} is also intresting in #{@event.name}"
  #   mail to: @friend.mail, subject: subject
  # end

  # The event will arrange in a week, don't forget the show!
  # def week_before_event(user)
  #   @user = user
  #   @content = 'Your order is created. Thank you!'
  #   subject =  "Hey! Your #{@event.name} comeing soon!"
  #   mail to: order.user.email, subject: subject
  # end
end
