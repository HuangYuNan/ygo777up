--aersahua
function c100170009.initial_effect(c)
	aux.AddSynchroProcedure(c,c100170009.tfilter,aux.NonTuner(),2)
	c:EnableReviveLimit()
	--cannot spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetCondition(c100170009.condition)
	e1:SetValue(c100170009.elimit)
	c:RegisterEffect(e1)
	--Disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_CHAIN_ACTIVATING)
	e2:SetOperation(c100170009.disop)
	c:RegisterEffect(e2)
	--cannot Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	c:RegisterEffect(e4)	
end
function c100170009.condition(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp
end
function c100170009.elimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c100170009.disop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if re:GetHandler():IsSetCard(0x5cd) then return false 
		else if loc==LOCATION_GRAVE or loc==LOCATION_HAND or loc==LOCATION_DECK or loc==LOCATION_EXTRA or loc==LOCATION_REMOVED then
		Duel.NegateEffect(ev)
		end
	end
end
function c100170009.tfilter(c)
	return c:IsSetCard(0x5cd)
end