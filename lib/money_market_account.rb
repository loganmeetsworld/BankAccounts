module Bank 
	class MoneyMarketAccount < Account 
		def initialize(account_id, balance, date_opened)
			@min_balance = 10_000
			@transaction_count = 0
			super
		end
		def withdraw(withdraw_amount)
			if @transaction_count < 6
				super
				@transaction_count += 1
			else
				puts "No more transactions are allowed this month."
		end

		def deposit(deposit_amount)
			if deposit_amount < 10_000
				if @transaction_count < 6
					super
					@transaction_count += 1
				else
					puts "No more transactions are allowed this month."
				end
			else
				super
			end
		end


	end
end