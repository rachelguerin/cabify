require 'colorize'
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

pricing_rules = { VOUCHER: {qty:2}, 
					TSHIRT: {qty:3,disc:0.95}
				}

# test 1
co = Checkout.new(pricing_rules)

co.scan :VOUCHER
co.scan :TSHIRT
co.scan :MUG

price = co.total

puts "Items: #{co.items.join(', ')}"
puts "Total: #{price}€".colorize(:red)

# # test 2
co2 = Checkout.new(pricing_rules)

co2.scan :VOUCHER
co2.scan :TSHIRT
co2.scan :VOUCHER

price2 = co2.total
puts "Items: #{co2.items.join(', ')}"
puts "Total: #{price2}€".colorize(:red)

# test 3
co3 = Checkout.new(pricing_rules)

co3.scan :TSHIRT
co3.scan :TSHIRT
co3.scan :TSHIRT
co3.scan :VOUCHER
co3.scan :TSHIRT

price3 = co3.total

puts "Items: #{co3.items.join(', ')}"
puts "Total: #{price3}€".colorize(:red)

# test 4
co4 = Checkout.new(pricing_rules)

co4.scan :VOUCHER
co4.scan :TSHIRT
co4.scan :VOUCHER
co4.scan :VOUCHER
co4.scan :MUG
co4.scan :TSHIRT
co4.scan :TSHIRT

price4 = co4.total
puts "Items: #{co4.items.join(', ')}"
puts "Total: #{price4}€".colorize(:red)
