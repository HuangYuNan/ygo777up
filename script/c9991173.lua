--Witness the End
function c9991173.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9991173.target)
	e1:SetOperation(c9991173.activate)
	c:RegisterEffect(e1)
end
function c9991173.check(tp)
	local g=Duel.GetMatchingGroup(function(c)
		return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_REPTILE)
	end,tp,LOCATION_MZONE,0,nil)
	return g:GetSum(function(c) return math.max(c:GetLevel(),c:GetRank()) end)>=15
end
function c9991173.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c9991173.check(tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,1-tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,1-tp,LOCATION_EXTRA)
end
function c9991173.activate(e,tp,eg,ep,ev,re,r,rp)
	if not c9991173.check(tp) then return end
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if g1:GetCount()>2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g1=g1:Select(1-tp,2,2,nil)
	end
	if g2:GetCount()>2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g2=g2:Select(1-tp,2,2,nil)
	end
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_RULE)
	local lp=Duel.GetLP(1-tp)
	if lp<=2000 then
		Duel.SetLP(1-tp,0)
	else
		Duel.SetLP(1-tp,lp-2000)
	end
end