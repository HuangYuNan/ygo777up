--操鸟术 越冬
function c1872323.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,1872323)
	e1:SetTarget(c1872323.target)
	e1:SetOperation(c1872323.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c1872323.checkop)
	c:RegisterEffect(e2)
	--Revive
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44508094,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c1872323.sumcon)
	e2:SetOperation(c1872323.sumop)
	c:RegisterEffect(e2)
	--cannot remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c1872323.tg)
	c:RegisterEffect(e2)
end
function c1872323.tg(e,c)
	return c:IsSetCard(0x298)
end
function c1872323.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6ab2)
end
function c1872323.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1872323.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1872323.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c1872323.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c1872323.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c1872323.rcon)
		e1:SetValue(1)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e2:SetValue(c1872323.efilter)
		tc:RegisterEffect(e2,true)
	end
	e:GetHandler():RegisterFlagEffect(1872323,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c1872323.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetOwner():GetFlagEffect(1872323)~=0
end
function c1872323.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c1872323.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c1872323.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c1872323.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetHandler():GetFirstCardTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE)
	 and c:GetFlagEffect(1872323)>0 then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end