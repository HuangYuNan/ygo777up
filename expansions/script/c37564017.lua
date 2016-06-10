--Blue Rose Ruin
function c37564017.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c37564017.condition)
	e1:SetCost(c37564017.cost)
	e1:SetCountLimit(1,37564017+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c37564017.target)
	e1:SetOperation(c37564017.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(37564017,ACTIVITY_SPSUMMON,c37564017.counterfilter)
end
function c37564017.counterfilter(c)
	return c:IsSetCard(0x770) or c:GetSummonLocation()~=LOCATION_EXTRA
end
function c37564017.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c37564017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(37564017,tp,ACTIVITY_SPSUMMON)==0 end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c37564017.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c37564017.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x770) and c:IsLocation(LOCATION_EXTRA)
end
function c37564017.filter(c,e,tp)
	return c:IsSetCard(0x770) and c:GetRank()==4 and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c37564017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564017.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564017.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564017.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		e:GetHandler():CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(e:GetHandler()))
	end
end
