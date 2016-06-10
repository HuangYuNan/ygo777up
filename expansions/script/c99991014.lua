--步兵「敢死小分队」
function c99991014.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,99991014+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c99991014.condition)
	e1:SetCost(c99991014.cost)
	e1:SetTarget(c99991014.target)
	e1:SetOperation(c99991014.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(99991014,ACTIVITY_SPSUMMON,c99991014.counterfilter)
end
function c99991014.counterfilter(c)
	return c:IsSetCard(0x2e6)
end
function c99991014.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c99991014.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAlbeToDeckAsCost,tp,LOCATION_HAND,0,1,nil)
    and  Duel.GetCustomActivityCount(99991014,tp,ACTIVITY_SPSUMMON)==0 	end
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c99991014.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c99991014.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x2e6)
end
function c99991014.spfilter(c,e,tp)
	return c:IsSetCard(0x2e6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c99991014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c99991014.spfilter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c99991014.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c99991014.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
	    if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0  and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
	    local tg=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
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
		Duel.RaiseSingleEvent(tc,99991001,e,0,tp,0,0)
		 Duel.RaiseEvent(e:GetHandler(),99991003,e,0,tp,0,0)
		end
	end
end
end
end