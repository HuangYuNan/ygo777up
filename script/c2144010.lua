--尤格德尔西鲁之匙
function c2144010.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c2144010.descon)
	e1:SetOperation(c2144010.desop)
	c:RegisterEffect(e1)
end
function c2144010.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x215)
end
function c2144010.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2144010.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c2144010.cfilter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x215) and c:IsReleasable()
end
function c2144010.cfilter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x215) and c:IsAbleToHand()
end
function c2144010.desop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c2144010.cfilter2,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c2144010.cfilter1,tp,LOCATION_MZONE,0,nil)
	local opt=0
	if g1:GetCount()>1 and g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(2144010,0),aux.Stringid(2144010,1))
	elseif g1:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(2144010,0))
	elseif g2:GetCount()>0 and g1:GetCount()>1 then
		opt=Duel.SelectOption(tp,aux.Stringid(2144010,1))+1
	else return end
	if opt==0 then
		local dg=Duel.SelectMatchingCard(tp,c2144010.cfilter1,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(dg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,dg)
	else
		local g3=g2:Select(tp,1,1,nil)
		local g4=g1:Select(tp,1,1,nil)
		g1:Remove(Card.IsCode,nil,g4:GetFirst():GetCode())
		if g1:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g5=g1:Select(tp,1,1,nil)
			g1:Remove(Card.IsCode,nil,g5:GetFirst():GetCode())
			g4:Merge(g5)
		end
		if Duel.SendtoGrave(g3,REASON_EFFECT) then
			Duel.SendtoHand(g4,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g4)
		end
	end
end