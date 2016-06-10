--请问您今天要来乘凉吗
function c23456713.initial_effect(c)
	--Activate(effect)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,23456713+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c23456713.condition)
	e1:SetTarget(c23456713.target)
	e1:SetOperation(c23456713.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c23456713.handcon)
	c:RegisterEffect(e2)
end
function c23456713.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x532)
end
function c23456713.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c23456713.cfilter,tp,LOCATION_ONFIELD,0,1,nil) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c23456713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c23456713.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c23456713.handfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x532) and c:IsType(TYPE_MONSTER)
end
function c23456713.handcon(e)
	return Duel.IsExistingMatchingCard(c23456713.handfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
