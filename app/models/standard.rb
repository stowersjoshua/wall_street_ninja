class Standard < User # :nodoc:

	def total_purchase
		self.active_portfolio.purchases.map(&:quantity).sum + self.total_sales
	end

	def total_sales
		self.active_portfolio.sales.map(&:quantity).sum
	end

	def total_earning
		earning = self.total_balance - 100000
		if earning < 0
			return 0 
		else
			return earning
		end
	end
end
