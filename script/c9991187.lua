--Void Shatter
function c9991187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCost(c9991187.cost)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetCurrentChain()==0
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local rg=eg:Filter(c9991187.filter1,nil,tp)
		if chk==0 then return rg:GetCount()~=0 end
		Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,rg,rg:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,rg:GetCount(),0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local rg=eg:Filter(c9991187.filter1,nil,tp)
		Duel.NegateSummon(rg)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCost(c9991187.cost)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
		if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
			Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
		end
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e2)
end
function c9991187.filter1(c,tp)
	return c:GetSummonPlayer()~=tp
end
function c9991187.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	g=g:Select(tp,1,1,nil)
	Duel.HintSelection(g)
	Duel.SendtoGrave(g,REASON_COST+REASON_RETURN)
end