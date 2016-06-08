--魔物少女 狂犬
function c30303057.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xabb),4,2)
	c:EnableReviveLimit()
	--EQ
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30303057,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c30303057.cost)
	e1:SetTarget(c30303057.tg)
	e1:SetOperation(c30303057.op)
	c:RegisterEffect(e1)
end
function c30303057.filter1(c)
	return c:IsAbleToDeck()
end
function c30303057.filter2(c)
	return c:IsAbleToRemove()
end
function c30303057.filter3(c)
	return c:IsAbleToGrave()
end
function c30303057.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c30303057.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return false end
	local b1=Duel.IsExistingTarget(c30303057.filter1,tp,0,LOCATION_ONFIELD,1,nil)
	local b2=Duel.IsExistingTarget(c30303057.filter2,tp,0,LOCATION_ONFIELD,1,nil)
	local b3=Duel.IsExistingTarget(c30303057.filter3,tp,0,LOCATION_ONFIELD,1,nil) 
	if chk==0 then return b1 or b2 or b3 end
	local op=0
	if b1 and b2 and b3 then op=Duel.SelectOption(tp,aux.Stringid(30303057,1),aux.Stringid(30303057,2),aux.Stringid(30303057,3))
	elseif b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(3033102,1),aux.Stringid(30303057,2))
	elseif b1 and b3 then op=Duel.SelectOption(tp,aux.Stringid(3033102,1),aux.Stringid(30303057,3))
	elseif b2 and b3 then op=Duel.SelectOption(tp,aux.Stringid(3033102,2),aux.Stringid(30303057,3))
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(3033102,1))
	elseif b2 then op=Duel.SelectOption(tp,aux.Stringid(3033102,2))+1
	else op=Duel.SelectOption(tp,aux.Stringid(3033102,3))+2 end
	e:SetLabel(op)
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c30303057.filter1,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	elseif op==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectTarget(tp,c30303057.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectTarget(tp,c30303057.filter3,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	end
end
function c30303057.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	elseif e:GetLabel()==1 then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end