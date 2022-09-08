require 'pry'

class Event
	attr_accessor :handlers

	def initialize
		@handlers = []
	end

	def subscribe(&block)
		@handlers << block
	end

	def unsubscribe(&block)
		tester = 1
		@handlers.each do |h|
			@handlers.delete(h) if h.call(tester) == block.call(tester)
		end
	end

	def broadcast(*args)
		result = []
		@handlers.each do |h|
			args.each do |a|
				result << h.call(a)
			end
		end
		result
	end
end
