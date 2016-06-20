--神王圣宫 温妮莎
function c18750404.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--pendulum
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c18750404.target)
	e1:SetOperation(c18750404.operation)
	c:RegisterEffect(e1)
	--LV down
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_LVCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCondition(c18750404.condition2)
	e2:SetOperation(c18750404.operation2)
	c:RegisterEffect(e2)
	--SPECIAL_SUMMON
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_LVCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c18750404.condition3)
	e3:SetTarget(c18750404.target3)
	e3:SetOperation(c18750404.operation3)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TODECK+CATEGORY_LVCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c18750404.target3)
	e4:SetOperation(c18750404.operation3)
	c:RegisterEffect(e4)
end
function c18750404.desfilter(c)
	return c:IsSetCard(0xab3) and c:IsAbleToExtra()
end
function c18750404.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c18750404.desfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c18750404.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,c18750404.desfilter,p,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	local lc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-p,g)
		local ct=Duel.PSendtoExtra(g,nil,REASON_EFFECT)
		Duel.ShuffleHand(p)
		if lc:IsLevelAbove(1) and Duel.SelectYesNo(tp,aux.Stringid(18750404,0)) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(lc:GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		e:GetHandler():RegisterEffect(e2)
		end
	end
end
function c18750404.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_DECK)
end
function c18750404.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_EXTRA,0):Filter(Card.IsSetCard,nil,0xab3)
	local tc=hg:GetFirst()
	ac=Duel.AnnounceNumber(tp,2,1)
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-ac)
		e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=hg:GetNext()
	end
end
function c18750404.filter(c)
	return c:IsSetCard(0xab3) and c:IsAbleToDeck()
end
function c18750404.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0xab3) and not c:IsType(TYPE_XYZ)
end
function c18750404.condition3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c18750404.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c18750404.filter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE+LOCATION_EXTRA)
end
function c18750404.operation3(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,c18750404.filter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE+LOCATION_EXTRA,0,1,99,nil)
	if g:GetCount()>0 then
	local ct=g:GetCount()
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	local sg=Duel.GetMatchingGroup(c18750404.filter2,tp,LOCATION_MZONE,0,nil)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
	end
end