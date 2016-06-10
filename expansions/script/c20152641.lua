--勇气の圣剑
function c20152641.initial_effect(c)
c:SetUniqueOnField(1,1,20152641)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c20152641.target)
	e1:SetOperation(c20152641.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c20152641.eqlimit)
	c:RegisterEffect(e2)
		--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(1000)
	c:RegisterEffect(e3)
		--remove overlay replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152641,0))
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c20152641.rcon)
	e4:SetOperation(c20152641.rop)
	c:RegisterEffect(e4)
		--immune
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c20152641.imcon)
	e6:SetOperation(c20152641.imop)
	c:RegisterEffect(e6)
end
function c20152641.eqlimit(e,c)
	return c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152641.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152641.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152641.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152641.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c20152641.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c20152641.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c20152641.imcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler():GetEquipTarget() or Duel.GetAttackTarget()==e:GetHandler():GetEquipTarget()
end
function c20152641.imop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetEquipTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c20152641.efilter2)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	bc:RegisterEffect(e1,true)
end
function c20152641.efilter2(e,te)
	return te:IsActiveType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and te:GetOwner()~=e:GetOwner()
end
function c20152641.rcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_COST)~=0 and re:GetHandler():IsType(TYPE_XYZ)
		and ep==e:GetOwnerPlayer() and e:GetHandler():GetEquipTarget()==re:GetHandler() and re:GetHandler():GetOverlayCount()>=ev-1
end
function c20152641.rop(e,tp,eg,ep,ev,re,r,rp)
	local ct=bit.band(ev,0xffff)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	if ct>1 then
		re:GetHandler():RemoveOverlayCard(tp,ct-1,ct-1,REASON_COST)
	end
end
