--守护女神  白色妹妹
function c1101139.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1241),4,2,c1101139.ovfilter,aux.Stringid(1101139,0),2,c1101139.xyzop)
	c:EnableReviveLimit()
	--rank change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101139,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1101139.remcon)
	e1:SetTarget(c1101139.target)
	e1:SetOperation(c1101139.operation)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetRange(LOCATION_OVERLAY)
	e3:SetCondition(c1101139.efcon)
	e3:SetOperation(c1101139.efop)
	c:RegisterEffect(e3)
end
function c1101139.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c1101139.ovfilter(c)
	return c:IsFaceup() and c:IsCode(1101103) 
end
function c1101139.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101139.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c1101139.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c1101139.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ	
end
function c1101139.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c1101139.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	for i=1,4 do t[i]=i end
	local Rank=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(1101139,1))
	local c=e:GetHandler()
	local op=0
	op=Duel.SelectOption(tp,aux.Stringid(1101139,2),aux.Stringid(1101139,3),aux.Stringid(1101139,4))
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
function c1101139.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c1101139.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(1101139,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_LEAVE)
	e1:SetCondition(c1101139.eqcon)
	e1:SetTarget(c1101139.eqtg)
	e1:SetOperation(c1101139.activate)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetValue(TYPE_MONSTER+TYPE_EFFECT+TYPE_XYZ)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2)
	end
end
function c1101139.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c1101139.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetBattleTarget() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c1101139.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetBattleTarget():GetCode()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND,nil,code)
	Duel.Destroy(g,REASON_EFFECT)
	local deck=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND)
	if deck:GetCount()~=0 then Duel.ShuffleDeck(1-tp) end
end