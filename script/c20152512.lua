--超现实の词语接龙
function c20152512.initial_effect(c)
	aux.AddRitualProcEqual2(c,c20152512.ritual_filter)
		--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152512,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,20152512)
	e2:SetCost(c20152512.cost2)
	e2:SetTarget(c20152512.target2)
	e2:SetOperation(c20152512.operation2)
	c:RegisterEffect(e2)
end
function c20152512.ritual_filter(c)
	local code=c:GetCode()
	return code==20152504
end
function c20152512.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c20152512.filter2(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c20152512.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c20152512.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152512.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20152512.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20152512.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end