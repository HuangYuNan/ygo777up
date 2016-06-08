--鲁格·贝奥武夫-兽化模式
function c1007014.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x245),10,2)
end
