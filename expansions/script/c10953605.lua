--幻想御手
function c10953605.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10953605+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c10953605.target)
	e1:SetOperation(c10953605.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c10953605.desop)
	c:RegisterEffect(e2)
	--Destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c10953605.descon2)
	e3:SetOperation(c10953605.desop2)
	c:RegisterEffect(e3)
end
function c10953605.cfilter(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 and lv<=2 and c:IsSetCard(0x23c)
		and Duel.IsExistingMatchingCard(c10953605.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,lv+2,e,tp)
end
function c10953605.filter(c,lv,e,tp)
	return c:GetLevel()<=lv and c:IsSetCard(0x23c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10953605.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(tp,c10953605.cfilter,1,nil,e,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c10953605.cfilter,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetLevel()+2)
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c10953605.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10953605.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e:GetLabel(),e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		c:SetCardTarget(tc)
	end
end
function c10953605.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c10953605.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c10953605.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
