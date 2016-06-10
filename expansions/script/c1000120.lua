--式神姬·水无月
function c1000120.initial_effect(c)
	c:EnableReviveLimit()
	--②
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetDescription(aux.Stringid(30646525,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1000120.condition)
	e1:SetCost(c1000120.cost)
	e1:SetTarget(c1000120.target)
	e1:SetOperation(c1000120.operation)
	c:RegisterEffect(e1)
end
function c1000120.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL
end
function c1000120.spfilter(c)
	return c:IsSetCard(0x3202) and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c1000120.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)
	and Duel.IsExistingMatchingCard(c1000120.spfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.PayLPCost(tp,1000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c1000120.spfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c1000120.filter(c)
	return c:IsDestructable()
end
function c1000120.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c1000120.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c1000120.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c1000120.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	local ct=Duel.Destroy(g,REASON_EFFECT)
end