--空降斯巴达
function c75646003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75646003+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c75646003.condition)
	e1:SetCost(c75646003.cost)
	e1:SetTarget(c75646003.target)
	e1:SetOperation(c75646003.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(75646003,ACTIVITY_SPSUMMON,c75646003.counterfilter)
end
function c75646003.counterfilter(c)
	return c:IsSetCard(0x2c1)
end
function c75646003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(75646003,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c75646003.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c75646003.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x2c1)
end
function c75646003.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c75646003.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x2c1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75646003.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c75646003.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75646003.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end