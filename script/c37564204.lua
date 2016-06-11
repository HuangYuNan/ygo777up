--Sawawa-Pattern Fire
if not senya then local io=require('io') local chk=io.open("expansions/script/c37564765.lua","r") if chk then chk:close() require "expansions/script/c37564765" else require "script/c37564765" end end
function c37564204.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564204,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(senya.swwblex)
	e2:SetCost(senya.swwrmcost(1))
	e2:SetOperation(c37564204.atkop)
	c:RegisterEffect(e2)
	senya.sww(c,1,true,false,false)
end
function c37564204.atkop(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
		e1:SetTarget(c37564204.rmtg(e,c))
		e1:SetTargetRange(0,0xff)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
end
function c37564204.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer()
end