require 'pry'
require 'colorize'
require_relative 'checkout.rb'

TWOFORONE = Rule.new(2,0.5)
MORETHAN3 = Rule.new(3,0.95)

VOUCHER = Item.new(5,'Cabify Voucher',TWOFORONE)
TSHIRT = Item.new(20,'Cabify T-Shirt',MORETHAN3)
MUG = Item.new(7.5,'Cabify Coffee Mug')

# test 1
co = Checkout.new

co.scan TSHIRT
co.scan VOUCHER
co.scan MUG

co.print

# test 2
co2 = Checkout.new

co2.scan VOUCHER
co2.scan TSHIRT
co2.scan VOUCHER

co2.print

# test 3
co3 = Checkout.new

co3.scan TSHIRT
co3.scan TSHIRT
co3.scan TSHIRT
co3.scan VOUCHER
co3.scan TSHIRT

co3.print

# # test 4
co4 = Checkout.new

co4.scan VOUCHER
co4.scan TSHIRT
co4.scan VOUCHER
co4.scan VOUCHER
co4.scan MUG
co4.scan TSHIRT
co4.scan TSHIRT

co4.print
