class PurchasesController < ApplicationController
  def new
    @products = Product.where("stock > 0")
    @denominations = Denomination.order(value: :desc)
  end

  def create
    ActiveRecord::Base.transaction do
      customer = Customer.find_or_create_by!(email: params[:email])

      purchase = Purchase.create!(
        customer: customer
      )

      total = 0

      params[:items].each do |item|
        product = Product.find(item[:product_id])
        quantity = item[:quantity].to_i

        raise "Invalid quantity" if quantity <= 0
        raise "Insufficient stock for #{product.name}" if quantity > product.stock

        base_price = product.price * quantity
        tax = ((base_price * product.tax_percentage) / 100).round(2)
        line_total = base_price + tax

        PurchaseItem.create!(
          purchase: purchase,
          product: product,
          quantity: quantity,
          unit_price: product.price,
          tax_amount: tax,
          total_price: line_total
        )

        product.update!(stock: product.stock - quantity)
        total += line_total
      end

      total = total.round(2)

      paid_amount = 0

      params[:denominations].each do |d|
        count = d[:count].to_i
        next if count <= 0

        denom = Denomination.find(d[:id])
        paid_amount += denom.value * count

        PurchaseDenomination.create!(
          purchase: purchase,
          denomination: denom,
          count: count,
          direction: "in"
        )

        denom.update!(available_count: denom.available_count + count)
      end

      raise "Paid amount is less than total bill" if paid_amount < total

      balance = paid_amount - total
      remaining = balance.to_i


      Denomination.order(value: :desc).each do |denom|
        break if remaining <= 0

        needed = (remaining / denom.value).floor
        usable = [ needed, denom.available_count ].min

        next if usable <= 0

        PurchaseDenomination.create!(
          purchase: purchase,
          denomination: denom,
          count: usable,
          direction: "out"
        )

        denom.update!(available_count: denom.available_count - usable)
        remaining -= usable * denom.value
      end

      raise "Cannot return exact change with available denominations" if remaining > 0

      purchase.update!(
        total_amount: total,
        paid_amount: paid_amount,
        balance_amount: balance
      )

      InvoiceMailer.with(purchase: purchase).invoice_email.deliver_later

      redirect_to purchase_path(purchase)
    end

  rescue => e
    redirect_to new_purchase_path, alert: e.message
  end

  def show
    @purchase = Purchase.includes(
      :purchase_items,
      purchase_denominations: :denomination
    ).find(params[:id])

    @items = @purchase.purchase_items

    @total_without_tax = @items.sum { |i| i.unit_price * i.quantity }
    @total_tax = @items.sum(&:tax_amount)
    @net_total = @purchase.total_amount

    @rounded_total = @net_total.floor
    @balance = @purchase.balance_amount

    @cash_received =
      @purchase.purchase_denominations.where(direction: "in")

    @change_denominations =
      @purchase.purchase_denominations.where(direction: "out")
  end
end
