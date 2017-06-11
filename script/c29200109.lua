--凋叶棕-胎儿之梦
function c29200109.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c29200109.spcon)
	e1:SetTarget(c29200109.sptg)
	e1:SetOperation(c29200109.spop)
	c:RegisterEffect(e1)
	--atkup
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetCode(EFFECT_UPDATE_ATTACK)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c29200109.val)
	c:RegisterEffect(e10)
	local e2=e10:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
c29200109.dyz_utai_list=true
function c29200109.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c29200109.val(e,c)
	return Duel.GetMatchingGroupCount(c29200109.filter,0,LOCATION_MZONE,LOCATION_MZONE,c,c:GetCode())*500
end
function c29200109.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:IsSetCard(0x53e0) and not c:IsCode(29200109)
end
function c29200109.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return rp==tp and eg:GetFirst():IsSetCard(0x53e0)
end
function c29200109.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29200109.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=eg:GetFirst()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		if ec:IsRelateToEffect(e) and ec:IsFaceup() then
		local code=ec:GetCode()
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(29200109,1))
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_CODE)
		e2:SetValue(code)
		e2:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
