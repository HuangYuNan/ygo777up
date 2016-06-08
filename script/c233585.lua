--金曜
function c233585.initial_effect(c)
    --Activate
 	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c233585.target)
	e1:SetOperation(c233585.operation)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(233585,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(0x8)
	e2:SetCondition(c233585.atkcon)
	e2:SetOperation(c233585.atkop)
	c:RegisterEffect(e2)
	--Indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c233585.eqlimit)
	c:RegisterEffect(e4)
end
function c233585.eqlimit(e,c)
	return c:GetOriginalRace()==0x2
end
function c233585.filter(c)
	return c:IsFaceup() and c:IsRace(0x2)
end
function c233585.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x4) and c233585.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c233585.filter,tp,0x4,0x4,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c233585.filter,tp,0x4,0x4,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c233585.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c233585.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()~=nil
end
function c233585.atkop(e,tp,eg,ep,ev,re,r,rp)
    local tc=e:GetHandler():GetEquipTarget()
	local te=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_EFFECT)
	local c=te:GetHandler()
	if te:IsHasType(EFFECT_TYPE_ACTIVATE) and c:IsType(TYPE_SPELL) and c~=e:GetHandler() and tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
	    local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
        e2:SetCode(EVENT_ADJUST)
		e2:SetLabelObject(e1)
		e2:SetOperation(c233585.op)
        Duel.RegisterEffect(e2,tp)
	end
end
function c233585.op(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetLabelObject() then return end
	local c=e:GetHandler()
	if c:IsDisabled() then
	e:GetLabelObject():Reset() 
	elseif not c:IsOnField() then
	e:GetLabelObject():Reset() 
	e:Reset()
	end
end	