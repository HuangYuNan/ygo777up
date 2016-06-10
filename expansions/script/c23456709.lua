--请问您今天要来点兔子吗
function c23456709.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23456709+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c23456709.activate)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23456709,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c23456709.target)
	e2:SetOperation(c23456709.operation)
	c:RegisterEffect(e2)
   --inactivatable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_INACTIVATE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(c23456709.efilter1)
	c:RegisterEffect(e3)
end
function c23456709.thfilter(c)
	return  c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23456709.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c23456709.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23456709,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c23456709.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x532) and c:IsAbleToHand()
end
function c23456709.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c23456709.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23456709.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c23456709.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c23456709.sumfilter(c)
	return c:IsSetCard(0x532) and c:IsSummonable(true,nil)
end
function c23456709.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		if Duel.IsExistingMatchingCard(c23456709.sumfilter,tp,LOCATION_HAND,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(23456709,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local g=Duel.SelectMatchingCard(tp,c23456709.sumfilter,tp,LOCATION_HAND,0,1,1,nil)
			Duel.Summon(tp,g:GetFirst(),true,nil)
		end
	end
end
function c23456709.efilter1(e,ct)
	local te=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT)
	local tc=te:GetHandler()
	return te:IsActiveType(TYPE_MONSTER) and tc:IsSetCard(0x532) and tc:IsLocation(LOCATION_ONFIELD)
end
