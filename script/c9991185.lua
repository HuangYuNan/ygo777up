--Horribly Awry
function c9991185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>0 and Duel.GetCurrentChain()==0
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local rg=eg:Filter(c9991185.filter1,nil,tp)
		if chk==0 then return rg:GetCount()~=0 end
		Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,rg,rg:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,rg:GetCount(),0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local rg=eg:Filter(c9991185.filter1,nil,tp)
		Duel.NegateSummon(rg)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e2)
end
function c9991185.filter1(c,tp)
	return c:GetSummonPlayer()~=tp and math.max(c:GetOriginalLevel(),c:GetOriginalRank())<=4
end