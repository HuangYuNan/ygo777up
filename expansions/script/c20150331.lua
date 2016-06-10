--天使·灼烂歼鬼
function c20150331.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c20150331.target)
	e1:SetOperation(c20150331.operation)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c20150331.atkval)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetValue(c20150331.valcon)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c20150331.equiplimit)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20150331,0))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c20150331.descon)
	e5:SetTarget(c20150331.destg)
	e5:SetOperation(c20150331.desop)
	c:RegisterEffect(e5)
end
function c20150331.equiplimit(e,c)
	return c:IsCode(20150304)
end
function c20150331.filter(c)
	return c:IsFaceup() and c:IsCode(20150304)
end
function c20150331.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20150331.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150331.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c20150331.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c20150331.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c20150331.atkval(e,c)
	if c:IsDefensePos() then return 0 else return 1000 end
end
function c20150331.cfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCode(20150304)
end
function c20150331.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20150331.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c20150331.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	local d=g:GetFirst()
	local atk=0
	if d:IsFaceup() then atk=d:GetAttack() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk/2)
end
function c20150331.desop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local tc=Duel.GetFirstTarget()
			if tc:IsRelateToEffect(e) then
		local atk=0
		if tc:IsFaceup() then atk=tc:GetAttack() end
		if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		Duel.Damage(1-tp,atk/2,REASON_EFFECT)
		if ec then
		Duel.ChangePosition(ec,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
	end
end