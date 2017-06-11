--anbutiangou
function c100170005.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,100170005)
	e1:SetCost(c100170005.spcost)
	e1:SetTarget(c100170005.sptg)
	e1:SetOperation(c100170005.spop)
	c:RegisterEffect(e1)
	e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--Chariot Check
	if not c100170005.global_check then
		c100170005.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c100170005.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
--Chariot Check Counter count
function c100170005.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if not tc:IsSetCard(0x5cd) then 
			if tc:GetSummonPlayer()==0 then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,100170005,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,100170005,RESET_PHASE+PHASE_END,0,1) end
end
--Chariot Check Cost Check
function c100170005.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100170005)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c100170005.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end 
function c100170005.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x5cd) and e:GetLabelObject()~=se
end
function c100170005.filter(c,e,tp)
	return c:IsDEFENSEBelow(1500) and c:IsSetCard(0x5cd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100170005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100170005.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100170005.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100170005.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		--local e3=Effect.CreateEffect(c)
		--e3:SetType(EFFECT_TYPE_FIELD)
		--e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		--e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		--e3:SetTargetRange(1,0)
		--e3:SetReset(PHASE_END+EVENT_PHASE)
		--e3:SetTarget(c100170005.splimit)
		--c:RegisterEffect(e3,tp)
		Duel.SpecialSummonComplete()
	end
end
function c100170005.splimit(e,c)
	return not c:IsSetCard(0x5cd)
end
function c100170005.splimit1(e,c)
	return not c:IsSetCard(0x5cd)
end