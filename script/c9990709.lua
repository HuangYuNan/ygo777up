--巻き戻し
function c9990709.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,9990709+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c9990709.target)
	e1:SetOperation(c9990709.activate)
	c:RegisterEffect(e1)
end
function c9990709.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c9990709.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)==0 then return end
	if not tc:IsLocation(LOCATION_REMOVED) then return end
	local cp=tc:GetOwner()
	if Duel.GetLocationCount(cp,LOCATION_MZONE)==0 then return Duel.SendtoGrave(tc,REASON_RULE) end
	Duel.MoveToField(tc,cp,cp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
end