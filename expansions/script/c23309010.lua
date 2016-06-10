--幻想「花鸟风月、啸风弄月」
function c23309010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c23309010.cost)
	e1:SetTarget(c23309010.target)
	e1:SetOperation(c23309010.activate)
	c:RegisterEffect(e1)
end
function c23309010.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x99a) and c:IsAbleToDeckAsCost()
end
function c23309010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23309010.cfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,4,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c23309010.cfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,4,4,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c23309010.filter(c,e,tp)
	return c:IsSetCard(0x99a) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c23309010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23309010.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23309010.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23309010.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
