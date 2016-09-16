require 'pry'

class Checkout
	attr_reader :items

	def initialize(pricing_rules)
		@pricing_rules = pricing_rules
		@items = []
		@total = 0
	end

	def scan(item)
		@items << item
	end

	def calc_total
		return @items.uniq.map {|i| calc_item_total(i)}.reduce(0) {|sum,item| sum + item }
	end

	def calc_item_total(item)
		qty = @items.select {|i| i == item}.count
		case item
		when :VOUCHER 
			return ((qty / @pricing_rules[item][:qty])*item[:price])+ ((qty % @pricing_rules[item][:qty])*item[:price])
		when :TSHIRT
			return qty < @pricing_rules[item][:qty] ? qty * item[:price] : qty * item[:price] * @pricing_rules[item][:disc] 
		else 
			return qty * item[:price]
		end
	end

	def total
		return "%.2f" % calc_total
	end

end

class Item
	attr_reader :price,:description
	def initialize(price,description)
		@price = price
		@description = description
	end

end

class Rule
	attr_reader :qty,:discount
	def initialize(qty,discount)
		@qty = qty
		@discount = discount
	end
end
