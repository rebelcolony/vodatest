describe "Subscribe" do
	it "should take a block and stores it" do
		event = Event.new
		event.subscribe { puts "hello from inside the block" }
	end
end
