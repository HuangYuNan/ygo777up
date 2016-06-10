--
function c20329003.initial_effect(c)
	 --synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsLevelAbove,4),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Cannot activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c20329003.aclimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,20329003)
	e2:SetCost(c20329003.spcost)
	e2:SetTarget(c20329003.sptg)
	e2:SetOperation(c20329003.spop)
	c:RegisterEffect(e2)
end
function c20329003.aclimit(e,re,tp)
	local tc=re:GetHandler()
	return (tc:IsLevelBelow(3) or tc:IsRankBelow(3)) and re:IsActiveType(TYPE_MONSTER) and not tc:IsImmuneToEffect(e)
end
function c20329003.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c20329003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c20329003.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c20329003.filter1(c,e,tp)
	local lv=c:GetLevel()
	return lv>4 and not c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingMatchingCard(c20329003.filter2,tp,LOCATION_GRAVE,0,1,c,e,lv)
end
function c20329003.filter2(c,e,lv)
	return c:GetLevel()==lv and not c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20329003.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c20329003.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc1=g1:GetFirst()
	local lv=tc1:GetLevel()
	local g2=Duel.SelectMatchingCard(tp,c20329003.filter2,tp,LOCATION_GRAVE,0,1,1,tc1,e,lv)
	if g1:GetCount()<1 or g2:GetCount()<1 then return end
	local tc2=g2:GetFirst()
	Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEUP)
	Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc1:RegisterEffect(e1)
	local e2=e1:Clone()
	tc2:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	tc1:RegisterEffect(e3)
	local e4=e3:Clone()
	tc2:RegisterEffect(e4)
	Duel.SpecialSummonComplete()
end 