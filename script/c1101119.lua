--女神进化
function c1101119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,11120)
	e1:SetCost(c1101119.cost)
	e1:SetOperation(c1101119.activate)
	c:RegisterEffect(e1)
end
function c1101119.tfilter(c,att,e,tp)
	return c:IsSetCard(0x1241) and  c:IsType(TYPE_FUSION) and c:IsAttribute(att) and c:IsCanBeSpecialSummoned(e,0,tp,true,ture)
end
function c1101119.filter(c,e,tp)
	local att=c:GetAttribute()
	return   c:IsSetCard(0x1241) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c1101119.tfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,att,e,tp)
end
function c1101119.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c1101119.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1101119.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e,tp)
	local att=g:GetFirst():GetAttribute()
	Duel.SendtoGrave(g,REASON_EFFECT)
	e:SetLabel(att)
end
function c1101119.activate(e,tp,eg,ep,ev,re,r,rp)
	local att=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c1101119.tfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil,att,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
