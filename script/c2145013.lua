--修罗觉醒 艾拉
function c2145013.initial_effect(c)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2145013,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,2145013)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c2145013.sptg)
	e3:SetOperation(c2145013.spop)
	c:RegisterEffect(e3)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c2145013.reptg)
	e1:SetValue(c2145013.repval)
	e1:SetOperation(c2145013.repop)
	c:RegisterEffect(e1)
end
function c2145013.filter(c,e,tp)
	return c:IsSetCard(0x216) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c2145013.filter1(c)
	return c:IsSetCard(0x216) and c:IsDiscardable()
end
function c2145013.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c2145013.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c2145013.filter1,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c2145013.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c2145013.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local g1=Duel.GetMatchingGroup(c2145013.filter1,tp,LOCATION_HAND,0,nil)
	local tc=g:GetFirst()
	if tc and g1:GetCount()>0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,c2145013.filter1,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoGrave(g2,REASON_EFFECT+REASON_DISCARD)
	end
end
function c2145013.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x216)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c2145013.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c2145013.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(2145013,0))
end
function c2145013.repval(e,c)
	return c2145013.repfilter(c,e:GetHandlerPlayer())
end
function c2145013.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
