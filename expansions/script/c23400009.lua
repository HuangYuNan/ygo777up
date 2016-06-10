--疾风迅雷
function c23400009.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,23400009+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c23400009.condition)
	e1:SetTarget(c23400009.target)
	e1:SetOperation(c23400009.activate)
	c:RegisterEffect(e1)
	--Activate(summon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetCountLimit(1,23400009+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c23400009.condition1)
	e2:SetTarget(c23400009.target1)
	e2:SetOperation(c23400009.activate1)
	c:RegisterEffect(e2)
end
function c23400009.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c23400009.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
	and Duel.GetCurrentChain()==0 
end
function c23400009.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c23400009.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end

------
function c23400009.cfilter(c)
	return c:IsFaceup() and c:IsCode(23400004)
end
function c23400009.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c23400009.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c23400009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c23400009.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end