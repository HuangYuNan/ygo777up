--ALO•莉法
function c20152633.initial_effect(c)
	c:SetUniqueOnField(1,1,20152633)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152633.ovfilter,aux.Stringid(20152633,7),3,nil)
	c:EnableReviveLimit()
			--in
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c20152633.condition2)
	e1:SetTarget(c20152633.etarget2)
	e1:SetValue(c20152633.efilter2)
	c:RegisterEffect(e1)
			--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152633,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c20152633.cost)
	e2:SetOperation(c20152633.operation)
	c:RegisterEffect(e2)
	--remove material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(63504681,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c20152633.rmcon)
	e3:SetCost(c20152633.rmcost)
	e3:SetTarget(c20152633.rmtg)
	e3:SetOperation(c20152633.rmop)
	c:RegisterEffect(e3)
	end
function c20152633.ovfilter(c)
	return c:IsCode(20152603) and c:IsFaceup()
end
function c20152633.etarget2(e,c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152633.efilter2(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c20152633.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152603)
end
function c20152633.cost(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c20152633.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290)
end
function c20152633.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20152633.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c20152633.efilter)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c20152633.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
function c20152633.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c20152633.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152633.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c20152633.rmop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
