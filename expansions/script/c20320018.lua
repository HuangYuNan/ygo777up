--Rbit
function c20320018.initial_effect(c)
	aux.EnableDualAttribute(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20320018.cost)
	e2:SetTarget(c20320018.target)
	e2:SetOperation(c20320018.op)
	c:RegisterEffect(e2)
	--to hand2
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1) 
	e3:SetCondition(aux.IsDualState)
	e3:SetTarget(c20320018.thtg)
	e3:SetOperation(c20320018.thop)
	c:RegisterEffect(e3)
end
function c20320018.filter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDiscardable()
end
function c20320018.filter2(c)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c20320018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320018.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20320018.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20320018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320018.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c20320018.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20320018.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20320018.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c20320018.desfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable() and Duel.IsExistingMatchingCard(c20320018.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetOriginalCode())
end
function c20320018.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c20320018.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320018.desfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20320018.desfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20320018.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c20320018.thfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetOriginalCode())
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end