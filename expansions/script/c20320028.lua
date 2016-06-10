--Sengoku Hongou
function c20320028.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--race change 
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20320028.rccost)
	e2:SetTarget(c20320028.rctg)
	e2:SetOperation(c20320028.rcop)
	c:RegisterEffect(e2)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c20320028.thtg)
	e1:SetOperation(c20320028.thop)
	c:RegisterEffect(e1)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c20320028.tdcon)
	e3:SetTarget(c20320028.tdtg)
	e3:SetOperation(c20320028.tdop)
	c:RegisterEffect(e3)
end
function c20320028.cfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x280) and c:IsType(TYPE_MONSTER)
end
function c20320028.rccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20320028.cfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c20320028.rcfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c20320028.rctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20320028.rcfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320028.rcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c20320028.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,563)
	local rc=Duel.AnnounceRace(tp,1,0xffffff)
	e:SetLabel(rc)
end
function c20320028.rcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end
function c20320028.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c20320028.thfilter2(c)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c20320028.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c20320028.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320028.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c20320028.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20320028.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
	Duel.BreakEffect()
	local dg=Duel.GetMatchingGroup(c20320028.thfilter2,tp,LOCATION_GRAVE,0,nil)
	if dg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(20320028,0)) then
		Duel.SendtoHand(dg:Select(tp,1,1,nil),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,dg)
	end
end
function c20320028.filter(c)
	return c:IsFaceup() and not c:IsDisabled() and c:IsType(TYPE_EFFECT)
end
function c20320028.tdcon(e)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c20320028.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20320028.filter(chkc) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	if chk==0 then return Duel.IsExistingTarget(c20320028.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20320028.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0) 
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c20320028.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_NORMAL)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_REMOVE_TYPE)
		e4:SetValue(TYPE_EFFECT)
		tc:RegisterEffect(e4)
	end
	if c:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,0,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_DECK) then
		Duel.ShuffleDeck(tp)
	end
end