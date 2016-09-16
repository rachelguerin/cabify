require 'pry'
require 'colorize'
require_relative 'checkout.rb'

pricing_rules = { VOUCHER: {qty:2}, 
					TSHIRT: {qty:3,disc:0.95}
				}

VOUCHER = Item.new(5,'Cabify Voucher')
TSHIRT = Item.new(20,'Cabify T-Shirt')
MUG = Item.new(7.5,'Cabify Coffee Mug')

TWOFORONE = Rule.new(2,0.5)
MORETHAN3 = Rule.new(3,0.95)

# test 1
co = Checkout.new(pricing_rules)

co.scan VOUCHER
co.scan TSHIRT
co.scan MUG

binding.pry

# price = co.total

# puts "Items: #{co.items.join(', ')}"
# puts "Total: #{price}€".colorize(:red)

# # # test 2
# co2 = Checkout.new(pricing_rules)

# co2.scan :VOUCHER
# co2.scan :TSHIRT
# co2.scan :VOUCHER

# price2 = co2.total
# puts "Items: #{co2.items.join(', ')}"
# puts "Total: #{price2}€".colorize(:red)

# # test 3
# co3 = Checkout.new(pricing_rules)

# co3.scan :TSHIRT
# co3.scan :TSHIRT
# co3.scan :TSHIRT
# co3.scan :VOUCHER
# co3.scan :TSHIRT

# price3 = co3.total

# puts "Items: #{co3.items.join(', ')}"
# puts "Total: #{price3}€".colorize(:red)

# # test 4
# co4 = Checkout.new(pricing_rules)

# co4.scan :VOUCHER
# co4.scan :TSHIRT
# co4.scan :VOUCHER
# co4.scan :VOUCHER
# co4.scan :MUG
# co4.scan :TSHIRT
# co4.scan :TSHIRT

# price4 = co4.total
# puts "Items: #{co4.items.join(', ')}"
# puts "Total: #{price4}€".colorize(:red)
