--бнзреп МќХЬ
function c3201002.initial_effect(c)	
--synchro limit
    local e1=Effect.CreateEffect(c)
	  e1:SetType(EFFECT_TYPE_SINGLE)
	  e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	  e1:SetValue(c3201002.synlimit)
	  c:RegisterEffect(e1)
--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x341))
	c:RegisterEffect(e1)
--token
    local e2=Effect.CreateEffect(c)
	  e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	  e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	  e2:SetDescription(aux.Stringid(3201002,1))
	  e2:SetProperty(EFFECT_FLAG_DELAY)
	  e2:SetCode(EVENT_TO_GRAVE)
	  e2:SetCountLimit(1,3201002)
	  e2:SetTarget(c3201002.sptg1)
	  e2:SetOperation(c3201002.spop1)
	  c:RegisterEffect(e2)
end
function c12992431.synlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x341)
end
function c3201002.cfilter(c,tp)
	return c:IsSetCard(0x341) and c:IsType(TYPE_MONSTER) and not c:IsCode(3201002)
end
function c3201002.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c3201002.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,12992430)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end