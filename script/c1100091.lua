--辉针城·今泉影狼
function c1100091.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c1100091.ffilter,2,false)
	--Cannot activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c1100091.aclimit)
	c:RegisterEffect(e1)
	--halve LP
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1100091,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c1100091.hvcon)
	e3:SetOperation(c1100091.hvop)
	c:RegisterEffect(e3)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetCondition(c1100091.becon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_EP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c1100091.becon)
	c:RegisterEffect(e2)
end
function c1100091.becon(e)
	return e:GetHandler():IsAttackable()
end
function c1100091.ffilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_BEASTWARRIOR) 
end
function c1100091.aclimit(e,re,tp,tc)
	local tc=re:GetHandler()
	return tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() and tc:GetAttack()==tc:GetBaseAttack() and re:IsActiveType(TYPE_MONSTER) and not tc:IsImmuneToEffect(e)
end
function c1100091.hvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttack()>e:GetHandler():GetBaseAttack()
end
function c1100091.hvop(e,tp,eg,ep,ev,re,r,rp)
	 Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end