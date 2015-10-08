module Bank 
	class MoneyMarketAccount < Account 
		def initialize(account_id, balance, date_opened)
			@min_balance = 1000000
			super
		end
	end
end