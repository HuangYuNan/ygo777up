--花之终-璀璨的凋亡
function c10953017.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,10953017+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c10953017.condition)
	e1:SetCost(c10953017.spcost)
	e1:SetTarget(c10953017.rmtg)
	e1:SetOperation(c10953017.rmop)
	c:RegisterEffect(e1)	
end
function c10953017.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x234) and c:IsType(TYPE_MONSTER)
end
function c10953017.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10953017.filter,tp,LOCATION_MZONE,0,1,nil) or Duel.IsExistingMatchingCard(c10953017.filter,tp,LOCATION_REMOVED,0,1,nil)
end
function c10953017.cfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function c10953017.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10953017.cfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10953017.cfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c10953017.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c10953017.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
