class OrderMailer < ApplicationMailer
  def receipt_email(order, line_item)
    @order = order
    @line_item = line_item
    mail(to: @order.email, from: 'no-reply@jungle.com', subject: "Your order receipt (Order ##{order.id}) from Jungle") do |format|
      format.html
    end
  end
end
