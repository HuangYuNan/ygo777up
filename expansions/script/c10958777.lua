--先驱之大天使·该隐
function c10958777.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),aux.NonTuner(c10958777.sfilter),1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.synlimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	e2:SetValue(c10958777.efilter)
	c:RegisterEffect(e2)   
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10958777,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c10958777.spcon)
	e3:SetOperation(c10958777.skipop)
	c:RegisterEffect(e3) 
end
function c10958777.sfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_SYNCHRO)
end
function c10958777.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and not e:GetHandler():IsType(TYPE_SYNCHRO)
end
function c10958777.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetPreviousControler()==tp
end
function c10958777.skipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetCode())
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_BP)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
