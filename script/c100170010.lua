--zhishidajian
function c100170010.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100170010.target)
	e1:SetOperation(c100170010.operation)
	c:RegisterEffect(e1)
	--atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c100170010.value)
	c:RegisterEffect(e2)
	e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c100170010.eqlimit)
	c:RegisterEffect(e4)
end
function c100170010.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwner()~=e:GetOwner()
end
function c100170010.eqlimit(e,c)
	return c:IsSetCard(0x5cd) and c:IsRace(RACE_BEASTWARRIOR)
end
function c100170010.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5cd) and c:IsRace(RACE_BEASTWARRIOR)
end
function c100170010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c100170010.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100170010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100170010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100170010.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c100170010.cfilter(c)
	return c:IsRace(RACE_BEASTWARRIOR) 
end
function c100170010.value(e,c)
	return Duel.GetMatchingGroupCount(c100170010.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)*1000
end
