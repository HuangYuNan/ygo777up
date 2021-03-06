--Balefire Dragon
function c9990309.initial_effect(c)
	--Synchro
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Burn!
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetOperation(c9990309.operation)
	c:RegisterEffect(e1)
	--Auto Death
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_TOGRAVE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c9990309.filter)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c9990309.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local atk=e:GetHandler():GetAttack() local sc=g:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(-atk)
			sc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			sc:RegisterEffect(e2)
			sc=g:GetNext()
		end
	end
end
function c9990309.filter(e,c)
	return c:GetAttack()==0 and c:GetDefense()==0 and c:IsFaceup() and not c:IsImmuneToEffect(e)
end
