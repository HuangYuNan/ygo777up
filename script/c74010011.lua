--昆西：你是笨蛋么？
function c74010011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetTarget(c74010011.target)
	e1:SetOperation(c74010011.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c74010011.handcon)
	c:RegisterEffect(e2)
	--win
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetOperation(c74010011.winop)
	c:RegisterEffect(e3)
end
function c74010011.filter2(c)
	return c:IsSetCard(0x3740)
end
function c74010011.filter(c)
	return c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3740)
end
function c74010011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()==tp and chkc:GetLocation()==LOCATION_GRAVE and c74010011.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c74010011.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c74010011.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c74010011.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		local mg=Duel.GetMatchingGroup(c74010011.filter2,tp,LOCATION_REMOVED,0,nil)
		if mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(74010011,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74010011,1))
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
		end
	end
end
function c74010011.hdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x3740)
end
function c74010011.handcon(e)
	return not Duel.IsExistingMatchingCard(c74010011.hdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c74010011.winop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c74010011.filter2,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>=27 then
		Duel.Win(tp,0x4)
	end
end