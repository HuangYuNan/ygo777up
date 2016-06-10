--�ػ�Ů��  ��ɫ����
function c1101130.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1241),4,2,c1101130.ovfilter,aux.Stringid(1101130,0),2,c1101130.xyzop)
	c:EnableReviveLimit()
	--rank change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101130,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1101130.remcon)
	e1:SetTarget(c1101130.target)
	e1:SetOperation(c1101130.operation)
	c:RegisterEffect(e1)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c1101130.efcon)
	e2:SetOperation(c1101130.efop)
	c:RegisterEffect(e2)
end
function c1101130.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c1101130.ovfilter(c)
	return c:IsFaceup() and c:IsCode(1101101)
end
function c1101130.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101130.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c1101130.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c1101130.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ  
end
function c1101130.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c1101130.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	for i=1,4 do t[i]=i end
	local Rank=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(1101130,1))
	local c=e:GetHandler()
	local op=0
	op=Duel.SelectOption(tp,aux.Stringid(1101130,2),aux.Stringid(1101130,3),aux.Stringid(1101130,4))
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
function c1101130.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c1101130.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(1101130,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1101130.atkcon)
	e1:SetOperation(c1101130.atkop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2,true)
	end
end
function c1101130.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c1101130.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end