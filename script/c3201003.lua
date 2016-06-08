--ÑÝ×àÕß µç¼ªËû
function c3201003.initial_effect(c)	
	--synchro limit
local e1=Effect.CreateEffect(c)
	  e1:SetType(EFFECT_TYPE_SINGLE)
	  e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	  e1:SetValue(c3201003.synlimit)
	  c:RegisterEffect(e1)
--spsummon
local e1=Effect.CreateEffect(c)
	  e1:SetDescription(aux.Stringid(3201003,0))
	  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	  e1:SetType(EFFECT_TYPE_IGNITION)
	  e1:SetRange(LOCATION_GRAVE)
	  e1:SetCountLimit(1,3201003)
	  e1:SetCost(c3201003.spcost2)
	  e1:SetTarget(c3201003.sptg2)
	  e1:SetOperation(c3201003.spop2)
	  c:RegisterEffect(e1)
--token
local e2=Effect.CreateEffect(c)
	  e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	  e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	  e2:SetProperty(EFFECT_FLAG_DELAY)
	  e2:SetCode(EVENT_TO_GRAVE)
	  e2:SetCountLimit(1,12992533)
	  e2:SetTarget(c3201003.sptg1)
	  e2:SetOperation(c3201003.spop1)
	  c:RegisterEffect(e2)
end
function c12992431.synlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x341)
end
function c3201003.cfilter2(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsSetCard(0x341)  and c:IsAbleToGraveAsCost()
end
function c3201003.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3201003.cfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c3201003.cfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c3201003.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c3201003.spop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c3201003.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c3201003.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,12992430)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end