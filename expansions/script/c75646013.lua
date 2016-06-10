--斯巴达四期 VALE
function c75646013.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCountLimit(1,75646013)
	e1:SetTarget(c75646013.target)
	e1:SetCost(c75646013.cost)
	e1:SetOperation(c75646013.operation)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(75646013,ACTIVITY_SPSUMMON,c75646013.counterfilter)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2c1))
	c:RegisterEffect(e2)
end
function c75646013.counterfilter(c)
	return c:IsSetCard(0x2c1)
end
function c75646013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
	and  Duel.GetCustomActivityCount(75646013,tp,ACTIVITY_SPSUMMON)==0  end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c75646013.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c75646013.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x2c1)
end
function c75646013.filter(c,e,tp)
	return c:IsSetCard(0x2c1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646013.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c75646013.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c75646013.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end