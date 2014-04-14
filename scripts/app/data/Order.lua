--
-- Author: dongxu
-- Date: 2014-03-15 20:06:32
--

Order = {}
Order.whiteOrder = 1
Order.blackOrder = -1

Order.value = Order.blackOrder

_G.Order = Order

function Order:getOrderValue()
	return self.value
end

function Order:switchOrder()
	local oldValue = self.value
	if self.value == self.whiteOrder then
		self.value = self.blackOrder
	else
		self.value = self.whiteOrder
	end
	return oldValue
end

return _G.Order