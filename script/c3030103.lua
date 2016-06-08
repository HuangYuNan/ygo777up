--聖女的儀式
function c3030103.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c3030103.target)
	e1:SetOperation(c3030103.activate)
	c:RegisterEffect(e1)
end
function c3030103.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3030103.sfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,1,nil,0,0)
end
function c3030103.activate(e,tp,eg,ep,ev,re,r,rp)
		local tg=Duel.GetMatchingGroup(c3030103.sfilter,tp,LOCATION_MZONE,0,nil)
		if tg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg=tg:Select(tp,1,5,nil)
		if sg:GetCount()>0 and Duel.ChangePosition(sg,POS_FACEUP_DEFENSE)~=0 then
		local ag=Duel.GetMatchingGroup(c3030103.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if ag:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(3030103,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			Duel.SpecialSummon(ag:Select(tp,1,1,nil),0,tp,tp,false,false,POS_FACEUP)
		end
end
end
end
function c3030103.sfilter(c)
	return c:IsFacedown() and c:IsSetCard(0x3e1)
end
function c3030103.spfilter(c,e,tp)
	return c:IsSetCard(0x3e3)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

