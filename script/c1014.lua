--步兵「敢死小分队」
function c1014.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1014+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c1014.condition)
	e1:SetCost(c1014.cost)
	e1:SetTarget(c1014.target)
	e1:SetOperation(c1014.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(1014,ACTIVITY_SPSUMMON,c1014.counterfilter)
end
function c1014.counterfilter(c)
	return c:IsSetCard(0x989)
end
function c1014.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c1014.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
    and  Duel.GetCustomActivityCount(1014,tp,ACTIVITY_SPSUMMON)==0 	end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c1014.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c1014.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x989)
end
function c1014.spfilter(c,e,tp)
	return c:IsSetCard(0x989) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1014.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c1014.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c1014.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
	    if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0  and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
	    local tg=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
		if tg:GetCount()>0   then 
		Duel.BreakEffect()
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		local tc=tg:GetFirst()
	    if  tc:IsFaceup() then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		Duel.RaiseSingleEvent(tc,1001,e,0,tp,0,0)
		 Duel.RaiseEvent(e:GetHandler(),1003,e,0,tp,0,0)
		end
	end
end
end
end