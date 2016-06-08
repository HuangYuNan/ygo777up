--月见的混沌天使 暗魂
function c2142011.initial_effect(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c2142011.discost)
	e2:SetCountLimit(1,2142011)
	e2:SetTarget(c2142011.target)
	e2:SetOperation(c2142011.operation)
	c:RegisterEffect(e2)
end
function c2142011.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c2142011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local mg=Duel.GetMatchingGroup(c2142011.matfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local dc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local dt=dc+1
	if chk==0 then return mg:CheckWithSumEqual(Card.GetLevel,c:GetLevel(),1,dt,c) end
end
function c2142011.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=c:GetLevel()
	local mg=Duel.GetMatchingGroup(c2142011.matfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local dc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if mg:CheckWithSumEqual(Card.GetLevel,c:GetLevel(),1,dc,c) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local mat=mg:SelectWithSumEqual(tp,Card.GetLevel,c:GetLevel(),1,dc,c)
		Duel.SpecialSummon(mat,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c2142011.matfilter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end