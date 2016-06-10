--守护女神  白色妹妹
function c1101143.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1241),4,2,c1101143.ovfilter,aux.Stringid(1101143,0),2,c1101143.xyzop)
	c:EnableReviveLimit()
	--rank change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101143,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1101143.remcon)
	e1:SetTarget(c1101143.target)
	e1:SetOperation(c1101143.operation)
	c:RegisterEffect(e1)
	--回手卡
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c1101143.descon)
	e3:SetTarget(c1101143.destg)
	e3:SetOperation(c1101143.desop)
	c:RegisterEffect(e3)
end
function c1101143.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c1101143.ovfilter(c)
	return c:IsFaceup() and  c:IsCode(1101104)
end
function c1101143.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101143.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c1101143.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c1101143.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ	
end
function c1101143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c1101143.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	for i=1,4 do t[i]=i end
	local Rank=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(1101143,1))
	local c=e:GetHandler()
	local op=0
	op=Duel.SelectOption(tp,aux.Stringid(1101143,2),aux.Stringid(1101143,3),aux.Stringid(1101143,4))
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_RANK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		if op==0 then
			e1:SetValue(Rank)
		else e1:SetValue(-Rank) end
		c:RegisterEffect(e1)
	end
end
function c1101143.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c1101143.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c1101143.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end