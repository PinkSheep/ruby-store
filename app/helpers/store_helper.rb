module StoreHelper
#  def number_to_chf(price)
#    number_to_currency(price, unit: "CHF", format: "%n %u")
#  end
  def number_to_currency(number, options={})
    options[:locale] ||= I18n.locale
    super(number, options)
  end
end
