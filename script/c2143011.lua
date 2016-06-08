--月世界 ORT
function c2143011.initial_effect(c)
	c:SetUniqueOnField(1,0,2143011)
	c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--sarch
	--local e3=Effect.CreateEffect(c)
	--e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e3:SetType(EFFECT_TYPE_IGNITION)
	--e3:SetRange(LOCATION_PZONE)
	--e3:SetCountLimit(1)
	--e3:SetTarget(c2143011.target)
	--e3:SetOperation(c2143011.activate)
	--c:RegisterEffect(e3)
	--spsummon limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c2143011.splimit)
	c:RegisterEffect(e3)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c2143011.condition)
	e1:SetTarget(c2143011.attg)
	e1:SetOperation(c2143011.atop)
	c:RegisterEffect(e1)
end
function c2143011.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c2143011.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,5) 
end
function c2143011.filter(c,tp)
	return c:IsType(TYPE_FIELD) and c:IsCode(2143012) and c:GetActivateEffect():IsActivatable(tp)
end
function c2143011.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2143011.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp) end
end
function c2143011.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2143011,0))
	local tc=Duel.SelectMatchingCard(tp,c2143011.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c2143011.filter1(c)
	return ((c:IsSetCard(0x213) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_RITUAL)) or c:IsType(TYPE_SPELL)) and c:IsAbleToDeck()
end
function c2143011.filter2(c)
	return c:IsSetCard(0x213) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c2143011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c2143011.filter1,tp,LOCATION_HAND,0,1,nil) and Duel.IsExistingTarget(c2143011.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2143011.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.SelectMatchingCard(tp,c2143011.filter1,tp,LOCATION_HAND,0,1,1,nil)
	local g2=Duel.SelectMatchingCard(tp,c2143011.filter2,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g1:GetFirst()
	if g2:GetCount()>0 then
		Duel.SendtoGrave(tc,nil,2,REASON_EFFECT+REASON_DISCARD)
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
	end
end 