require './checkout.rb'
require 'Rspec'

RSpec.describe "Checkout" do
	before :each do
		pricing_rules = { 
			VOUCHER: {qty:2,discount:0.5}, 
			TSHIRT: {qty:3,discount:0.95}, 
			MUG:{qty:1,discount:0}
		}
		@co = Checkout.new(pricing_rules)	
	end

	describe "initialize" do
		it "creates Checkout object" do
			expect(@co).to be_instance_of(Checkout)
		end

	end

	describe "only two vouchers" do
		it "is 5€" do
			@co.scan :VOUCHER
			@co.scan :VOUCHER

			expect(@co.total).to eq("5.00") 
		end
	end

	describe "one of each" do
		it "is 32.50" do
			@co.scan :VOUCHER
			@co.scan :TSHIRT
			@co.scan :MUG

			expect(@co.total).to eq("32.50")
		end
	end

	describe "two vouchers" do
		it "is 25.00" do
			@co.scan :VOUCHER
			@co.scan :TSHIRT
			@co.scan :VOUCHER

			expect(@co.total).to eq("25.00")
		end
	end

	describe "four shirts" do
		it "is 81.00" do
			@co.scan :TSHIRT
			@co.scan :TSHIRT
			@co.scan :TSHIRT
			@co.scan :VOUCHER
			@co.scan :TSHIRT

			expect(@co.total).to eq("81.00")
		end
	end

	describe "mixed bag" do
		it "is 74.50" do
			@co.scan :VOUCHER
			@co.scan :TSHIRT
			@co.scan :VOUCHER
			@co.scan :VOUCHER
			@co.scan :MUG
			@co.scan :TSHIRT
			@co.scan :TSHIRT

			expect(@co.total).to eq("74.50")
		end
	end

end

