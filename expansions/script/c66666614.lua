--群星永夜
function c66666614.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66666614,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,651)
	e1:SetCost(c66666614.cost)
	e1:SetCondition(c66666614.condition)
	e1:SetTarget(c66666614.target)
	e1:SetOperation(c66666614.operation)
	c:RegisterEffect(e1)
	if not c66666614.global_check then
		c66666614.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66666614.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66666614.clear)
		Duel.RegisterEffect(ge2,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66666614,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,651)
	e2:SetCost(c66666614.cost2)
	e2:SetCondition(c66666614.condition2)
	e2:SetTarget(c66666614.target2)
	e2:SetOperation(c66666614.operation2)
	c:RegisterEffect(e2)
	if not c66666614.global_check2 then
		c66666614.global_check2=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66666614.checkop2)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66666614.clear2)
		Duel.RegisterEffect(ge2,0)
	end
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,652)
	e3:SetHintTiming(0,TIMING_END_PHASE)
	e3:SetCost(c66666614.negcost)
	e3:SetTarget(c66666614.negtg)
	e3:SetOperation(c66666614.negop)
	c:RegisterEffect(e3)
	if not c66666614.global_check3 then
		c66666614.global_check3=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66666614.checkop3)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66666614.clear3)
		Duel.RegisterEffect(ge2,0)
	end
end
function c66666614.cfilter(c)
	return c:IsSetCard(0x661) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and c:IsFaceup()
end
function c66666614.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x661) then
			c66666614[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66666614.clear(e,tp,eg,ep,ev,re,r,rp)
	c66666614[0]=true
	c66666614[1]=true
end
function c66666614.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66666614.cfilter,tp,LOCATION_MZONE,0,1,nil) and c66666614[tp] end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c66666614.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,nil,2,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c66666614.sumlimit)
	Duel.RegisterEffect(e1,tp)
end
function c66666614.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x661)
end
function c66666614.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c66666614.filter(c,e,tp)
	return c:IsSetCard(0x661) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66666614.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66666614.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c66666614.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666614.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c66666614.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCountLimit(1)
		g:GetFirst():RegisterEffect(e1,true)
	end
end
function c66666614.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c66666614.costfilter(c,e,tp)
	return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c66666614.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,c,e,tp)
end
function c66666614.cfilter2(c,e,tp)
	return c:IsAbleToRemoveAsCost()
end
function c66666614.checkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x661) then
			c66666614[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66666614.clear2(e,tp,eg,ep,ev,re,r,rp)
	c66666614[0]=true
	c66666614[1]=true
end
function c66666614.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66666614.cfilter2,tp,LOCATION_HAND,0,1,nil) and c66666614[tp] end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c66666614.cfilter2,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,nil,2,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c66666614.sumlimit2)
	Duel.RegisterEffect(e1,tp)
end
function c66666614.sumlimit2(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x661)
end
function c66666614.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c66666614.filter2(c,e,tp)
	return c:IsSetCard(0x661) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66666614.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66666614.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c66666614.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666614.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c66666614.desop2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCountLimit(1)
		g:GetFirst():RegisterEffect(e1,true)
	end
end
function c66666614.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c66666614.checkop3(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x661) then
			c66666614[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66666614.clear3(e,tp,eg,ep,ev,re,r,rp)
	c66666614[0]=true
	c66666614[1]=true
end
function c66666614.negcostfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x661) and c:IsAbleToGraveAsCost()
end
function c66666614.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c66666614.negcostfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.DiscardHand(tp,c66666614.negcostfilter,1,1,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c66666614.sumlimit3)
	Duel.RegisterEffect(e1,tp)
end
function c66666614.sumlimit3(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x661)
end
function c66666614.negfilter(c,e,tp)
	return c:IsSetCard(0x661) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66666614.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66666614.filter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c66666614.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666614.negfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 and
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then
	end
end