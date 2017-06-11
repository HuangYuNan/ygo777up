--yekongdeyinying
function c100170012.initial_effect(c)
	--activate 
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCountLimit(1)
	e1:SetCondition(c100170012.condition)
	e1:SetTarget(c100170012.target)
	e1:SetCost(c100170012.cost)
	e1:SetOperation(c100170012.operation)
	c:RegisterEffect(e1)
end
function c100170012.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and tp~=ep
end
function c100170012.filter(c)
	return c:IsSetCard(0x5cd) and c:IsDestructable() and c:IsFaceup()
end
function c100170012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100170012.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_MESSAGE,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c100170012.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Destroy(g,REASON_DESTROY+REASON_COST)
end
function c100170012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c100170012.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
