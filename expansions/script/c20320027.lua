--Ruru
function c20320027.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCost(c20320027.spcost)
	e2:SetTarget(c20320027.sptg)
	e2:SetOperation(c20320027.spop)
	c:RegisterEffect(e2)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c20320027.drtg)
	e1:SetOperation(c20320027.drop)
	c:RegisterEffect(e1)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c20320027.lvcon)
	e3:SetTarget(c20320027.lvtg)
	e3:SetOperation(c20320027.lvop)
	c:RegisterEffect(e3)
	--Normal monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_TYPE)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCondition(c20320027.eqcon1)
	e4:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e4)
end
function c20320027.lvcon(e)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c20320027.cfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_MONSTER)
end
function c20320027.spfilter(c,e,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20320027.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320027.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20320027.cfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c20320027.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320027.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	local rc=Duel.AnnounceAttribute(tp,1,0xffff)
	e:SetLabel(rc)
end
function c20320027.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20320027.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	g:AddCard(c)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c20320027.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c20320027.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local ct=Duel.Draw(p,d,REASON_EFFECT)
	if ct==0 then return end
	local dc=Duel.GetOperatedGroup():GetFirst()
	if dc:IsSetCard(0x280) and Duel.IsPlayerCanDraw(tp,1)
			and Duel.SelectYesNo(tp,aux.Stringid(20320027,0)) then
			Duel.BreakEffect()
			Duel.ConfirmCards(1-tp,dc)
			Duel.Draw(tp,1,REASON_EFFECT)
			Duel.ShuffleHand(tp)
	end
end
function c20320027.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c20320027.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20320027.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320027.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20320027.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local t={}
	local i=1
	local p=1
	local lv=g:GetFirst():GetLevel()
	for i=1,12 do
		if lv~=i then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,567)
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c20320027.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
	if c:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,0,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_DECK) then
		Duel.ShuffleDeck(tp)
	end
end
function c20320027.eqcon1(e)
	return e:GetHandler():IsFaceup()
end