--明明是我先来的
function c10952001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c10952001.condition)
	e1:SetTarget(c10952001.target)
	e1:SetOperation(c10952001.activate)
	c:RegisterEffect(e1)
end
function c10952001.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,re:GetHandler():GetCode())
end
function c10952001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10952001.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=re:GetHandler():GetCode()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=Duel.GetCurrentChain()
	if ct>1 then
		c:CancelToGrave()
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end