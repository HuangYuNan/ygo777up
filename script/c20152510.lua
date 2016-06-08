		--现充の史蒂芬妮
function c20152510.initial_effect(c)
c:SetUniqueOnField(1,0,20152510)
	--synchro summon
 aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,20152503),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
			--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152510,1))
	e1:SetCategory(CATEGORY_TOHAND)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20152510.target2)
	e1:SetOperation(c20152510.operation2)
	c:RegisterEffect(e1)
		--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152510,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c20152510.thcon)
	e2:SetTarget(c20152510.thtg)
	e2:SetOperation(c20152510.thop)
	c:RegisterEffect(e2)
	end
	function c20152510.filter2(c)
	return c:IsAbleToHand() and c:IsFaceup()
end
function c20152510.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c20152510.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c20152510.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c20152510.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c20152510.thcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c20152510.thfilter(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c20152510.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c20152510.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152510.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20152510.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20152510.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
