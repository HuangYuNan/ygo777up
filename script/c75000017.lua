--神之曲 引導之章
function c75000017.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75000017)
	e1:SetCost(c75000017.cost)
	e1:SetTarget(c75000017.target)
	e1:SetOperation(c75000017.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(75000017,ACTIVITY_SPSUMMON,c75000017.counterfilter)
end
function c75000017.counterfilter(c)
	return c:IsSetCard(0x52f)
end
function c75000017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000017.filter1,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75000017.filter1,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,0,0,tp,0)
end
function c75000017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		or not (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil and Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end
function c75000017.filter1(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost()
end
function c75000017.spfilter(c,e,tp)
	return c:IsSetCard(0x52f) and c:GetLevel()==4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75000017.activate(e,tp,eg,ep,ev,re,r,rp)
	local off=1
	local ops={}
	local opval={}
	if Duel.IsExistingMatchingCard(c75000017.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		ops[off]=aux.Stringid(75000017,0)
		opval[off-1]=1
		off=off+1
	end
	if (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil and Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) then
		ops[off]=aux.Stringid(75000017,1)
		opval[off-1]=2
		off=off+1
	end
	if off==1 then return end
	local op=Duel.SelectOption(tp,table.unpack(ops))
	if opval[op]==1 then
		if chk==0 then return Duel.GetCustomActivityCount(75000017,tp,ACTIVITY_SPSUMMON)==0 end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c75000017.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local sg=Duel.SelectMatchingCard(tp,c75000017.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	elseif opval[op]==2 then
		local sg1=Duel.SelectMatchingCard(tp,c75000017.filter1,tp,LOCATION_DECK,0,2,2,nil)
		if sg1:GetCount()>1 then
			local tc1=sg1:GetFirst()
			local tc2=sg1:GetNext()
			Duel.MoveToField(tc1,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.MoveToField(tc2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
function c75000017.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x52f)
end