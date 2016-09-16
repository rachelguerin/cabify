require 'pry'
require_relative 'checkout.rb'

TWOFORONE = Rule.new(2,0.5,"((qty / item.rule.qty)*item.price)+ ((qty % item.rule.qty)*item.price)")
MORETHAN3 = Rule.new(3,0.95,"qty < item.rule.qty ? qty * item.price : qty * item.price * item.rule.discount")
NODISC = Rule.new(1,1,"qty * item.price")

VOUCHER = Item.new(5,'Cabify Voucher',TWOFORONE)
TSHIRT = Item.new(20,'Cabify T-Shirt',MORETHAN3)
MUG = Item.new(7.5,'Cabify Coffee Mug',NODISC)

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

# test 4
co4 = Checkout.new

co4.scan VOUCHER
co4.scan TSHIRT
co4.scan VOUCHER
co4.scan VOUCHER
co4.scan MUG
co4.scan TSHIRT
co4.scan TSHIRT

co4.print
