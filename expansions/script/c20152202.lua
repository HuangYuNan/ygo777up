--富樫勇太
function c20152202.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c20152202.target)
	e1:SetOperation(c20152202.operation)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152202,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,20152202)
	e2:SetCondition(c20152202.condition2)
	e2:SetTarget(c20152202.target2)
	e2:SetOperation(c20152202.operation2)
	c:RegisterEffect(e2)
end
function c20152202.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3290) and c:IsLevelAbove(1) and not c:IsCode(20152202)
end
function c20152202.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152202.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152202.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20152202.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	local op=0
	if tc:GetLevel()==1 then op=Duel.SelectOption(tp,aux.Stringid(20152202,1))
	else op=Duel.SelectOption(tp,aux.Stringid(20152202,1),aux.Stringid(20152202,2)) end
	e:SetLabel(op)
end
function c20152202.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else e1:SetValue(-1) end
		tc:RegisterEffect(e1)
	end
end
function c20152202.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c20152202.filter2(c)
	return c:GetCode()==20152201 and c:IsAbleToHand()
end
function c20152202.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20152202.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.GetFirstMatchingCard(c20152202.filter2,tp,LOCATION_DECK,0,nil)
	if tc~=nil then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
