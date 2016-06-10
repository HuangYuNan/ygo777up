--45745645
function c1101131.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1241),4,2,c1101131.ovfilter,aux.Stringid(1101131,0),2,c1101131.xyzop)
	c:EnableReviveLimit()
	--rank change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101131,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1101131.remcon)
	e1:SetTarget(c1101131.target)
	e1:SetOperation(c1101131.operation)
	c:RegisterEffect(e1)
	--bcsc
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c1101131.efcon)
	e2:SetOperation(c1101131.efop)
	c:RegisterEffect(e2)
end
function c1101131.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c1101131.ovfilter(c)
	return c:IsFaceup() and c:IsCode(1101102)
end
function c1101131.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101131.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c1101131.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c1101131.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ  
end
function c1101131.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c1101131.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	for i=1,4 do t[i]=i end
	local Rank=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(1101131,1))
	local c=e:GetHandler()
	local op=0
	op=Duel.SelectOption(tp,aux.Stringid(1101131,2),aux.Stringid(1101131,3),aux.Stringid(1101131,4))
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
function c1101131.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c1101131.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101131,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c1101131.discon)
	e1:SetCost(c1101131.discost)
	e1:SetTarget(c1101131.distg)
	e1:SetOperation(c1101131.disop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetValue(TYPE_MONSTER+TYPE_EFFECT+TYPE_XYZ)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2,true)
	end
end
function c1101131.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c1101131.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c1101131.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1101131.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end