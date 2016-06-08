--战符「小小军势」
function c99991011.initial_effect(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99991011.target)
	e1:SetOperation(c99991011.operation)
	c:RegisterEffect(e1)
end
function c99991011.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2e6)
end
function c99991011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99991011.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c99991011.operation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c99991011.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g1:GetFirst()
	while tc do
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(g1:GetCount()*100)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e3:SetValue(c99991011.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tg:RegisterEffect(e3)
		tc=g1:GetNext()
		end
end
function c99991011.efilter(e,te)
	return e:GetHandlerPlayer()~=te:GetHandlerPlayer() and not te:IsHasProperty(EFFECT_FLAG_CARD_TARGET)  
end
