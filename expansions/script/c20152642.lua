--激燃の狙击
function c20152642.initial_effect(c)
c:SetUniqueOnField(1,1,20152642)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c20152642.target)
	e1:SetOperation(c20152642.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c20152642.eqlimit)
	c:RegisterEffect(e2)
		--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(400)
	c:RegisterEffect(e3)
		--remove overlay replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152642,0))
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c20152642.rcon)
	e4:SetOperation(c20152642.rop)
	c:RegisterEffect(e4)
	--destroy
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(20152642,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetRange(LOCATION_SZONE)
		e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetCountLimit(1)
	e6:SetTarget(c20152642.destg)
	e6:SetOperation(c20152642.desop)
	c:RegisterEffect(e6)
end
function c20152642.eqlimit(e,c)
	return c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152642.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152642.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152642.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c20152642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c20152642.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c20152642.rcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_COST)~=0 and re:GetHandler():IsType(TYPE_XYZ)
		and ep==e:GetOwnerPlayer() and e:GetHandler():GetEquipTarget()==re:GetHandler() and re:GetHandler():GetOverlayCount()>=ev-1
end
function c20152642.rop(e,tp,eg,ep,ev,re,r,rp)
	local ct=bit.band(ev,0xffff)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	if ct>1 then
		re:GetHandler():RemoveOverlayCard(tp,ct-1,ct-1,REASON_COST)
	end
end
function c20152642.desfilter(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c20152642.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and c20152642.desfilter(chkc) end
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return eq and eq:IsAttackAbove(500)
		and Duel.IsExistingTarget(c20152642.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20152642.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20152642.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local eq=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or eq:IsImmuneToEffect(e) or not eq:IsAttackAbove(500) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	eq:RegisterEffect(e1)
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and tc:IsFacedown() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end