--希望的碎片
function c75646111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75646111)
	e1:SetLabel(0)
	e1:SetCost(c75646111.cost)
	e1:SetTarget(c75646111.target)
	e1:SetOperation(c75646111.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,75646111)
	e2:SetCost(c75646111.damcost)
	e2:SetTarget(c75646111.target1)
	e2:SetOperation(c75646111.damop)
	c:RegisterEffect(e2)
end
function c75646111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c75646111.filter1(c,e,tp)
	local Code=c:GetCode()
	return c:IsFaceup() and c:IsSetCard(0x2c0) and c:IsType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(c75646111.filter2,tp,LOCATION_DECK,0,1,nil,Code,e,tp)
end
function c75646111.filter2(c,Code,e,tp)
	return c:IsSetCard(0x2c0) and c:IsType(TYPE_MONSTER) and not c:IsCode(Code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646111.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.CheckReleaseGroup(tp,c75646111.filter1,1,nil,e,tp)
	end
	local rg=Duel.SelectReleaseGroup(tp,c75646111.filter1,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetCode())
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c75646111.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75646111.filter2,tp,LOCATION_DECK,0,1,1,nil,Code,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75646111.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c75646111.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsType(TYPE_SPELL) and c:IsSetCard(0x2c0)
end
function c75646111.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646111.filter,tp,LOCATION_SZONE,0,1,nil) end
end
function c75646111.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75646111.filter,tp,LOCATION_SZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end