require './checkout.rb'
require 'Rspec'

RSpec.describe "Checkout" do
	before :each do
		pricing_rules = { 
			VOUCHER: {qty:2,discount:0.5}, 
			TSHIRT: {qty:3,discount:0.95}, 
			MUG:{qty:1,discount:0}
		}
		VOUCHER = Item.new(5,'Cabify Voucher')
		TSHIRT = Item.new(20,'Cabify T-Shirt')
		MUG = Item.new(7.5,'Cabify Coffee Mug')

		@co = Checkout.new(pricing_rules)	
	end

	describe "initialize" do
		it "creates Checkout object" do
			expect(@co).to be_instance_of(Checkout)
		end

	end

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

RSpec.describe "Item" do
	before :each do
		@myItem = Item.new(2,'My first item')	
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

	end
end

RSpec.describe "Rule" do
	before :each do
		@myRule = Rule.new(2,0.5)	
	end

	describe "initialize" do

		it "creates Rule object" do		
			expect(@myRule).to be_instance_of(Rule)
		end

		it "sets qty to 2" do
			expect(@myRule.qty).to eq(2)
		end

		it "sets description to 'My first item'" do
			expect(@myRule.discount).to eq(0.5)
		end

	end
end

