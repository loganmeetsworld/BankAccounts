module Bank 
	class CheckingAccount < Account 
		def initialize(account_id, balance, date_opened)
			@min_balance = 0 
			super
		end

		def withdraw(withdraw_amount)
			transaction_fee = 100

			if @balance - withdraw_amount <= @min_balance
				puts "Don't drop below 0 dollars."
			else
				super
				@balance -= transaction_fee
				puts "Your updated balance is #{@balance}." 
			end
		end

		def withdraw_using_check(amount)
		end

		def reset_checks
			
		end
		
	end
end