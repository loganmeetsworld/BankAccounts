require 'money'

module Bank
	require 'csv'

	class Account

		attr_accessor :balance, :account_id

		def initialize(account_id, balance, date_opened)
			@account_id = account_id

			if balance < 0 
				raise ArgumentError.new("Cannot have a negative initial balance.")
			end

			@balance = balance
			@date_opened = DateTime.strptime(date_opened, "%Y-%m-%d %H:%M:%S %z")
		end

		def withdraw(withdraw_amount)
			withdraw_amount = withdraw_amount.to_i
			while withdraw_amount > @balance
				puts "Not enough money in this account."
				puts "The current balance is #{@balance}. Please put in a different amount."
				withdraw_amount = gets.chomp.to_i
			end

			@balance -= withdraw_amount.abs
			puts "Your updated balance is: #{@balance}."
		end

		def deposit(deposit_amount)
			@balance += @balance
			puts "Your updated balance is: #{@balance}."
		end

		def self.all 
			account_csv = CSV.read("./support/accounts.csv")
			account_instances = []

			account_csv.each do |row|
				account_instances << Account.new(row[0], row[1].to_i, row[2])
			end
			return account_instances
		end

		def self.find(id)
			self.all.find do |line|
				line.account_id.to_i == id
			end
		end
	end

	class Owner

		attr_accessor :identifier, :first_name, :last_name, :street, :city, :state, :account
	

		def initialize(owner_hash)
			@identifier = owner_hash[:identifier]
			@last_name = owner_hash[:last_name]
			@first_name = owner_hash[:first_name]
			@street = owner_hash[:street]
			@city = owner_hash[:city]
			@state = owner_hash[:state]
			@account = nil
		end

		def self.all 
			owner_csv = CSV.read("./support/owners.csv")

			owners_array = []

			owner_csv.each do |row|
				owner_hash = {:identifier => row[0], :last_name => row[1], :first_name => row[2], :street => row[3], :city => row[4], :state => row[5]}
				owners_array.push(Owner.new(owner_hash))
			end
			return owners_array
		end

		def self.find(id)
			self.all.find do |line|
				line.identifier.to_i == id
			end
		end

		def self.master_list

			master_list = []
			account_owner_csv = CSV.read("./support/account_owners.csv")

			account_owner_csv.each do |row|
				account_list = Bank::Account.find(row[0].to_i)
				account_owner = self.find(row[1].to_i)

				account_owner.account = account_list
				master_list.push(account_owner)
			end

			return master_list
			puts master_list.find(1212)
		end

	end
end