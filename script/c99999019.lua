--抹杀行动
function c99999019.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c99999019.condition1)
	e1:SetCost(c99999019.cost)
	e1:SetTarget(c99999019.target1)
	e1:SetOperation(c99999019.activate1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	--Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c99999019.condition2)
	e4:SetCost(c99999019.cost)
	e4:SetTarget(c99999019.target2)
	e4:SetOperation(c99999019.activate2)
	c:RegisterEffect(e4)
end
function c99999019.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0x2e5) and c:IsAbleToDeckAsCost()
end
function c99999019.condition1(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp  then return false end
	return Duel.GetCurrentChain()==0
end
function c99999019.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c99999019.cfilter,tp,LOCATION_MZONE,0,1,nil) end
    local g=Duel.SelectMatchingCard(tp,c99999019.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
 end
 function c99999019.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,eg:GetCount(),0,0)
end
function c99999019.refilter(c,code)
	return c:IsAbleToRemove() and c:GetCode()==code and c:IsFaceup()
end
function c99999019.activate1(e,tp,eg,ep,ev,re,r,rp)
   Duel.NegateSummon(eg) 
    if Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)>0 then
	local g=eg:GetFirst()
	while g do
	local tg=Duel.GetMatchingGroup(c99999019.refilter,tp,0,LOCATION_ONFIELD,nil,g:GetCode())
	if tg:GetCount()>0 then
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
	g=eg:GetNext()
	end
end
end
function c99999019.condition2(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp  then return false end
	return re:IsActiveType(TYPE_MONSTER)  and Duel.IsChainNegatable(ev)
end
function c99999019.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c99999019.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) and	Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)>0 then
    local g=eg:GetFirst()
	while g do
	local tg=Duel.GetMatchingGroup(c99999019.refilter,tp,0,LOCATION_ONFIELD,nil,g:GetCode())
	if tg:GetCount()>0 then
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
	g=eg:GetNext()
	end
end
end