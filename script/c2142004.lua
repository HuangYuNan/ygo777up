--祷告的月见天使 圣泉
function c2142004.initial_effect(c)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2142004,3))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c2142004.cost)
	e1:SetTarget(c2142004.target2)
	e1:SetOperation(c2142004.operation2)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2142004,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c2142004.descon)
	e2:SetOperation(c2142004.desop)
	c:RegisterEffect(e2)
end
function c2142004.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and re:GetHandler():IsRace(RACE_FAIRY) 
end
function c2142004.desfilter(c)
	return c:IsFacedown() and c:IsDestructable() 
end
function c2142004.filter2(c)
	return  bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and c:IsFaceup()
end
function c2142004.desop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c2142004.desfilter,tp,0,LOCATION_SZONE,nil)
	local g2=Duel.GetMatchingGroup(c2142004.filter2,tp,0,LOCATION_MZONE,nil)
	local opt=0
	if g1:GetCount()>0 and g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(2142004,1),aux.Stringid(2142004,2))
	elseif g1:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(2142004,1))
	elseif g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(2142004,2))+1
	else return end
	if opt==0 then
		local dg=g1:Select(tp,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g2:Select(tp,1,1,nil)
		Duel.ChangePosition(dg,POS_FACEDOWN_DEFENSE)
	end
end
function c2142004.cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c2142004.sfilter(c)
	return c:IsSetCard(0x212) and c:IsType(TYPE_SYNCHRO) and c:IsFaceup() 
end
function c2142004.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c2142004.sfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c2142004.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c2142004.sfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local t={}
		local i=1
		for i=1,4 do t[i]=i end
		local lv=Duel.AnnounceNumber(tp,table.unpack(t))
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2142004,4))
		local tg=Duel.SelectMatchingCard(tp,c2142004.sfilter,tp,LOCATION_MZONE,0,1,1,nil)
		local tc=tg:GetFirst()
		if  tc then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_UPDATE_LEVEL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(lv)
			tc:RegisterEffect(e1)
		end
	end
end
