--神之曲 炎袭之章
function c75000113.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c75000113.condition)
	e1:SetOperation(c75000113.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c75000113.handcon)
	c:RegisterEffect(e2)
end
function c75000113.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x52f) and (c:IsType(TYPE_SYNCHRO) or c:IsType(TYPE_XYZ))
end
function c75000113.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER)
end
function c75000113.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c75000113.filter1,tp,LOCATION_ONFIELD,0,1,nil)
end
function c75000113.handcon(e)
	local g=Duel.GetFieldGroup(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return g:IsExists(c75000113.cfilter,1,nil)
end
function c75000113.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM)
end
function c75000113.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c75000113.aclimit)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c75000113.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end