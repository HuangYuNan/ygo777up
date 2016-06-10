--请问您今天要来点红酒吗
function c23456714.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23456714+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c23456714.target)
	e1:SetOperation(c23456714.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c23456714.reptg)
	e2:SetValue(c23456714.repval)
	e2:SetOperation(c23456714.repop)
	c:RegisterEffect(e2)
end
function c23456714.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23456714.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c23456714.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23456714.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c23456714.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c23456714.sumfilter(c)
	return c:IsSetCard(0x532) and c:IsSummonable(true,nil)
end
function c23456714.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		if Duel.IsExistingMatchingCard(c23456714.sumfilter,tp,LOCATION_HAND,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(23456714,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local g=Duel.SelectMatchingCard(tp,c23456714.sumfilter,tp,LOCATION_HAND,0,1,1,nil)
			Duel.Summon(tp,g:GetFirst(),true,nil)
		end
	end
end
function c23456714.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_MZONE)
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c23456714.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c23456714.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(23456714,0))
end
function c23456714.repval(e,c)
	return c23456714.repfilter(c,e:GetHandlerPlayer())
end
function c23456714.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
