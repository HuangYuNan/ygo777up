--紫之星的后继者-魅儿
function c66666630.initial_effect(c)
	c:SetUniqueOnField(1,0,66666630)
	c:SetUniqueOnField(1,0,66666609)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x661),6,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c66666630.valcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66666630.indcon)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x661))
	e2:SetValue(c66666630.tgvalue)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c66666630.cost)
	e3:SetCondition(c66666630.tpcon)
	e3:SetTarget(c66666630.target)
	e3:SetOperation(c66666630.operation)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_CODE)
	e4:SetValue(66666609)
	c:RegisterEffect(e4)
end
function c66666630.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c66666630.indcon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c66666630.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c66666630.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66666630.cfilter(c,tp)
	return c:GetSummonPlayer()==1-tp
end
function c66666630.tpcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66666630.cfilter,1,nil,tp)
end
function c66666630.filter(c,e)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c66666630.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c66666630.filter,1,nil,nil) end
	local g=eg:Filter(c66666630.filter,nil,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c66666630.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c66666630.filter,nil,e)
	local tc=g:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c66666630.retop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	while tc do
		Duel.Remove(tc,tc:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)
		tc:RegisterFlagEffect(66666630,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end
function c66666630.retfilter(c)
	return c:GetFlagEffect(66666630)~=0
end
function c66666630.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c66666630.retfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.ReturnToField(tc)
		tc=g:GetNext()
	end 
end