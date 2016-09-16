require 'pry'

class Checkout
	attr_reader :items

	def initialize
		@items = []
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
		when VOUCHER 
			return ((qty / item.rule.qty)*item.price)+ ((qty % item.rule.qty)*item.price)
		when TSHIRT
			return qty < item.rule.qty ? qty * item.price : qty * item.price * item.rule.discount 
		else 
			return qty * item.price
		end
	end

	def total
		return "%.2f" % calc_total
	end

	def print
		puts "Items: #{items.map {|i| i.description}.join(', ')}"
		puts "Total: #{total}€".colorize(:red)
	end

end

class Item
	attr_reader :price,:description,:rule
	def initialize(price,description,rule=nil)
		@price = price
		@description = description
		@rule = rule
	end

end

class Rule
	attr_reader :qty,:discount
	def initialize(qty,discount)
		@qty = qty
		@discount = discount
	end
end
