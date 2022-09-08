require './event.rb'
require 'pry'

describe Event do
	before do
		@event = Event.new
	end

	it "should have a handlers array" do
		expect(@event.handlers).to eq([])
	end

	context "Subscribe:" do
		it "should take a block & add to the handlers array" do
			@event.subscribe { puts "hello from inside the block" }

			expect(@event.handlers.length).to eq(1)
		end

		it "create a proc object" do
			@event.subscribe { puts "hello from inside the block" }

			expect(@event.handlers.first.class).to eq(Proc)
		end

		it "can add multiple blocks" do
			@event.subscribe { |x| x * 1 } 
			@event.subscribe { |x| x * 2 } 
			@event.subscribe { |x| x * 2 } 

			expect(@event.handlers.length).to eq(3)
		end
	end

	context "Unusbscribe:" do
		it "should take a block & remove from the handlers array" do
			@event.subscribe { |x| x * 1 } 
			@event.subscribe { |x| x * 2 } 

			@event.unsubscribe { |x| x * 1 }

			expect(@event.handlers.length).to eq(1)
		end
	end

	context "Broadcast:" do
		it "calls a block with an argument" do
			@event.subscribe { |x| x * 1 }

			expect(@event.broadcast(1)).to eq([1])
		end

		it "calls a block with arguments" do
			@event.subscribe { |x| x * 1 }

			expect(@event.broadcast(1,2)).to eq([1, 2])
		end

		it "calls blocks with an argument" do
			@event.subscribe { |x| x * 1 }
			@event.subscribe { |x| x * 2 }

			expect(@event.broadcast(1)).to eq([1, 2])
		end

		it "calls blocks with arguments" do
			@event.subscribe { |x| x * 1 }
			@event.subscribe { |x| x * 2 }

			expect(@event.broadcast(1,2)).to eq([1, 2, 2, 4])
		end
	end
end
