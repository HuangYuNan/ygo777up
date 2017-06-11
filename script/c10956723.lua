--淳朴的光辉·霜之奇迹天使
function c10956723.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x239),aux.NonTuner(Card.IsSetCard,0x239),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISEFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e1:SetTarget(aux.true)
	e1:SetValue(1)
	c:RegisterEffect(e1)   
	--activate limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c10956723.cedop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c10956723.cedcon)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_CHAIN_END)
	e5:SetOperation(c10956723.cedop2)
	c:RegisterEffect(e5) 
	--cannot be target
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCondition(c10956723.tgcon)
	e12:SetValue(aux.imval1)
	c:RegisterEffect(e12)
end
function c10956723.cedcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst()~=e:GetHandler()
end
function c10956723.cedop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c10956723.chlimit2)
end
function c10956723.cedop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS) then
		Duel.SetChainLimitTillChainEnd(c10956723.chlimit2)
	end
end
function c10956723.chlimit2(re,rp,tp)
	return re:GetHandler():IsType(TYPE_TRAP) or re:GetHandler():IsType(TYPE_SPELL)
end
function c10956723.tgfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x239)
end
function c10956723.tgcon(e)
	return Duel.IsExistingMatchingCard(c10956723.tgfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end