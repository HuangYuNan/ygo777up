--Alter Matsuyukishiro
function c20320025.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--lvchange
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)   
	e2:SetCost(c20320025.spcost)
	e2:SetTarget(c20320025.lvtg)
	e2:SetOperation(c20320025.lvop)
	c:RegisterEffect(e2)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c20320025.thtg)
	e1:SetOperation(c20320025.thop)
	c:RegisterEffect(e1)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c20320025.tdcon)
	e3:SetTarget(c20320025.tdtg)
	e3:SetOperation(c20320025.tdop)
	c:RegisterEffect(e3)
end
function c20320025.tdcon(e)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c20320025.cfilter(c)
	return c:IsFaceup() and c:IsAbleToHandAsCost() and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_MONSTER)
end
function c20320025.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320025.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c20320025.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c20320025.filter(c,e,tp)
	return c:IsType(TYPE_PENDULUM) and c:GetLevel()>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20320025.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c20320025.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	local t={}
	local i=1
	local p=1
	for i=1,6 do
		t[p]=i p=p+1
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,567)	
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
end
function c20320025.lvop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingTarget(c20320025.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) then return end
	local g=Duel.SelectTarget(tp,c20320025.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c20320025.thfilter(c)
	return c:IsSetCard(0x280) and c:IsType(TYPE_MONSTER)
end
function c20320025.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320025.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20320025.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20320025.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20320025.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return e:GetHandler():IsAbleToDeck() and Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c20320025.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,0,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_DECK) then
		Duel.ShuffleDeck(tp)
	end
end