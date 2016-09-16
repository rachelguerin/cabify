
require 'pry'

class Checkout
	attr_reader :items

	def initialize(pricing_rules)
		@pricing_rules = pricing_rules
		@items = []
		@total = 0
		@prices = {
			VOUCHER:{price:5,description:'Cabify Voucher'},
			TSHIRT:{price:20,description:'Cabify T-Shirt'},
			MUG:{price:7.5,description:'Cabify Coffee Mug'}
		}
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
			return ((qty / @pricing_rules[item][:qty])*@prices[item][:price])+ ((qty % @pricing_rules[item][:qty])*@prices[item][:price])
		when :TSHIRT
			return qty < @pricing_rules[item][:qty] ? qty * @prices[item][:price] : qty * @prices[item][:price] * @pricing_rules[item][:disc] 
		else 
			return qty * @prices[item][:price]
		end
	end

	def total
		return "%.2f" % calc_total
	end

end

