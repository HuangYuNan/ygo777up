--无处不在
function c20320034.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c20320034.cost)
	e1:SetTarget(c20320034.target)
	e1:SetOperation(c20320034.activate)
	c:RegisterEffect(e1)
end
function c20320034.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,3) end
	Duel.DiscardDeck(tp,3,REASON_COST)
end
function c20320034.filter(c)
	return c:IsSetCard(0x280) and c:IsType(TYPE_PENDULUM) and Duel.IsExistingMatchingCard(c20320034.tedfilter,tp,LOCATION_DECK,0,1,nil,c:GetOriginalCode()) and c:IsFaceup()
end
function c20320034.tedfilter(c,code)
	return c:IsCode(code) and not c:IsForbidden()
end
function c20320034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20320034.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320034.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c20320034.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c20320034.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local code=tc:GetCode()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,code)
		if g:GetCount()>0 then
			Duel.SendtoExtraP(g,nil,REASON_EFFECT)
		end
	end
end