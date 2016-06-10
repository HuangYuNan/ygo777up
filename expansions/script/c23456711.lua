--请问您今天要来喝咖啡吗
function c23456711.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23456711+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c23456711.target)
	e1:SetOperation(c23456711.activate)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23456711,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c23456711.thtg)
	e2:SetOperation(c23456711.thop)
	c:RegisterEffect(e2)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetTarget(c23456711.tdtg)
	e3:SetOperation(c23456711.tdop)
	c:RegisterEffect(e3)
end
function c23456711.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c23456711.actfilter(c)
	return c:IsSetCard(0x532) and c:IsAbleToHand()
end
function c23456711.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(c23456711.actfilter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(23456711,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c23456711.actfilter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.SortDecktop(tp,tp,2)
	else Duel.SortDecktop(tp,tp,3) end
end
function c23456711.filter(c)
	return c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23456711.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c23456711.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23456711.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c23456711.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c23456711.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c23456711.rtfilter(c)
	return c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23456711.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c23456711.trfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23456711.trfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c23456711.rtfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c23456711.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end