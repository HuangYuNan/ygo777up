--凋叶棕-献歌-彼岸归航交响曲-
function c29200120.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,29200120+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c29200120.plcost)
	e1:SetTarget(c29200120.target)
	e1:SetOperation(c29200120.activate)
	c:RegisterEffect(e1)
	if not c29200120.global_check then
		c29200120.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c29200120.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_SUMMON_SUCCESS)
		ge2:SetOperation(c29200120.checkop1)
		Duel.RegisterEffect(ge2,0)
	end
end
function c29200120.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if not tc:IsSetCard(0x53e0) then
			if tc:GetSummonPlayer()==0 then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,29200120,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,29200120,RESET_PHASE+PHASE_END,0,1) end
end
--Limit
function c29200120.checkop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if not tc:IsSetCard(0x53e0) then
			if tc:GetSummonPlayer()==0 then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,29200109,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,29200109,RESET_PHASE+PHASE_END,0,1) end
end
function c29200120.counterfilter(c)
	return c:IsSetCard(0x53e0)
end
function c29200120.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,2928170)==0 
	and Duel.GetFlagEffect(tp,29200109)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c29200120.splimit)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c29200120.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x53e0)
end
function c29200120.filter1(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER)
end
function c29200120.filter2(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c29200120.sumfilter(c,e,tp)
	return c:IsSetCard(0x53e0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29200120.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,2) 
	and Duel.IsExistingMatchingCard(c29200120.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c29200120.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,2)
	if not Duel.IsPlayerCanDiscardDeck(tp,2) then return end
	Duel.ConfirmDecktop(tp,2)
	local g=Duel.GetDecktopGroup(tp,2)
	local rg=g:Filter(c29200120.filter1,nil)
	local sg=g:Filter(c29200120.filter2,nil)
	if rg:GetCount()>1 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c29200120.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c29200120.sumfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=g1:GetFirst()
		  if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 and c:IsRelateToEffect(e) 
			  and tc:IsType(TYPE_XYZ) then
			  Duel.DisableShuffleCheck()
			  Duel.Overlay(tc,rg)
		  else
			  Duel.SortDecktop(tp,tp,2)
				for i=1,2 do
				   local mg=Duel.GetDecktopGroup(tp,1)
				   Duel.MoveSequence(mg:GetFirst(),1)
				   Duel.RaiseSingleEvent(mg:GetFirst(),29200100,e,0,0,0,0)
				end
		 end
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetValue(500)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3,true)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_DEFENSE)
		e4:SetValue(500)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e4,true)
	elseif sg:GetCount()>0 then
			Duel.Damage(1-tp,800,REASON_EFFECT)
			Duel.Recover(tp,500,REASON_EFFECT)
		Duel.SortDecktop(tp,tp,2)
		for i=1,2 do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
			Duel.RaiseSingleEvent(mg:GetFirst(),29200100,e,0,0,0,0)
		end
	elseif sg:GetCount()<0 and rg:GetCount()<0 then
		Duel.SortDecktop(tp,tp,2)
		for i=1,2 do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
			Duel.RaiseSingleEvent(mg:GetFirst(),29200100,e,0,0,0,0)
		end
	end
end
