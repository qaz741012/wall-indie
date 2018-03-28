class UserMailer < ApplicationMailer
  default from: "My Cart <info@aplphacamp.co>"

  def week_before_event(user)
    @user = user
    @content = "Your order is created. Thank you!"

    mail to: order.user.email,
    subject: "ALPHA Camp | 訂單成立: #{@order.id}"
  end

end
