--��֮��   ��Ұ����
function c1103904.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),aux.NonTuner(Card.IsSetCard,0x1240),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1103904,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c1103904.eqcon)
	e1:SetTarget(c1103904.eqtg)
	e1:SetOperation(c1103904.eqop)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1103904,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,1103904)
	e2:SetTarget(c1103904.target)
	e2:SetOperation(c1103904.operation)
	c:RegisterEffect(e2)
end
function c1103904.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c1103904.filter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_FAIRY)
end
function c1103904.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1103904.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c1103904.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c1103904.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c1103904.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c1103904.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c1103904.eqlimit(e,c)
	return e:GetOwner()==c
end
function c1103904.filter1(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsRace(RACE_FAIRY)
end
function c1103904.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1103904.filter1,tp,LOCATION_MZONE,0,1,nil) end
end
function c1103904.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1103904.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetValue(1500)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_LEVEL)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetValue(1)
		c:RegisterEffect(e2)
	end
end