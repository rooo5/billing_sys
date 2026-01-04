class InvoiceMailer < ApplicationMailer
  def invoice_email
    @purchase = params[:purchase]
    @items = @purchase.purchase_items.includes(:product)  # load purchase items with products
    @total_without_tax = @items.sum { |i| i.unit_price * i.quantity }
    @total_tax = @items.sum(&:tax_amount)
    @net_total = @purchase.total_amount

    mail(
      to: @purchase.customer.email,
      subject: "Invoice ##{@purchase.id}"
    )
  end
end
