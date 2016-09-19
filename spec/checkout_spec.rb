require './checkout.rb'
require 'Rspec'

RSpec.describe "Item" do
	before :each do
		myRule = Proc.new do 
			discount * qty
		end
		@myItem = Item.new(2,'My first item',myRule)	
	end

	describe "initialize" do

		it "creates Item object" do		
			expect(@myItem).to be_instance_of(Item)
		end

		it "sets price to 2" do
			expect(@myItem.price).to eq(2)
		end

		it "sets description to 'My first item'" do
			expect(@myItem.description).to eq('My first item')
		end

		it "sets a rule" do
			expect(@myItem.rule).to be_instance_of(Proc)
		end

	end
end

# 

RSpec.describe "Checkout" do
	TWOFORONE = Proc.new do |qty, price|
	((qty / 2)*price)+ ((qty % 2)*price)
	end 

	MORETHAN3 = Proc.new do |qty, price|
		qty < 3 ? qty * price : qty * price * 0.95
	end

	NODISC = Proc.new do |qty, price|
		qty * price
	end

	VOUCHER = Item.new(5,'Cabify Voucher',TWOFORONE)
	TSHIRT = Item.new(20,'Cabify T-Shirt',MORETHAN3)
	MUG = Item.new(7.5,'Cabify Coffee Mug',NODISC)

	before :each do
		@co = Checkout.new	
	end

	describe "initialize" do
		it "creates Checkout object" do
			expect(@co).to be_instance_of(Checkout)
		end

	end

	describe "two for one discount" do
		it "correctly calculates voucher price" do
			@co.scan VOUCHER
			@co.scan VOUCHER

			expect(@co.total).to eq("5.00") 
			
			@co.scan VOUCHER
			expect(@co.total).to eq("10.00")

			@co.scan VOUCHER
			expect(@co.total).to eq("10.00")

			@co.scan VOUCHER
			expect(@co.total).to eq("15.00")
		end
	end

	describe "multiple purchase discount" do
		it "correctly calculates tshirt price" do
			@co.scan TSHIRT
			expect(@co.total).to eq("20.00")
			@co.scan TSHIRT
			expect(@co.total).to eq("40.00")
			@co.scan TSHIRT
			expect(@co.total).to eq("57.00")
			@co.scan TSHIRT
			expect(@co.total).to eq("76.00")
			@co.scan TSHIRT
			expect(@co.total).to eq("95.00")
		end
	end

	describe "no discount" do
		it "provides no discount for mugs" do
			@co.scan MUG
			expect(@co.total).to eq("7.50")
			@co.scan MUG
			expect(@co.total).to eq("15.00")
			@co.scan MUG
			expect(@co.total).to eq("22.50")
			@co.scan MUG
			expect(@co.total).to eq("30.00")
		end
	end

	# test cases for code challenge
	describe "only two vouchers" do
		it "is 5€" do
			@co.scan VOUCHER
			@co.scan VOUCHER

			expect(@co.total).to eq("5.00") 
		end
	end

	describe "one of each" do
		it "is 32.50" do
			@co.scan VOUCHER
			@co.scan TSHIRT
			@co.scan MUG

			expect(@co.total).to eq("32.50")
		end
	end

	describe "two vouchers" do
		it "is 25.00" do
			@co.scan VOUCHER
			@co.scan TSHIRT
			@co.scan VOUCHER

			expect(@co.total).to eq("25.00")
		end
	end

	describe "four shirts" do
		it "is 81.00" do
			@co.scan TSHIRT
			@co.scan TSHIRT
			@co.scan TSHIRT
			@co.scan VOUCHER
			@co.scan TSHIRT

			expect(@co.total).to eq("81.00")
		end
	end

	describe "mixed bag" do
		it "is 74.50" do
			@co.scan VOUCHER
			@co.scan TSHIRT
			@co.scan VOUCHER
			@co.scan VOUCHER
			@co.scan MUG
			@co.scan TSHIRT
			@co.scan TSHIRT

			expect(@co.total).to eq("74.50")
		end
	end

end



