--ÑÝ×àÕß ³¤µÑ
function c3201004.initial_effect(c)	
--synchro limit
local e2=Effect.CreateEffect(c)
	  e2:SetType(EFFECT_TYPE_SINGLE)
	  e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	  e2:SetValue(c3201004.synlimit)
	  c:RegisterEffect(e2)
--search
local e1=Effect.CreateEffect(c)
	  e1:SetDescription(aux.Stringid(3201004,0))
	  e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	  e1:SetType(EFFECT_TYPE_IGNITION)
	  e1:SetCountLimit(1,3201004)
	  e1:SetRange(LOCATION_MZONE)
	  e1:SetCost(c3201004.cost)
	  e1:SetTarget(c3201004.target)
	  e1:SetOperation(c3201004.operation)
	  c:RegisterEffect(e1)
--token
local e3=Effect.CreateEffect(c)
	  e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	  e3:SetProperty(EFFECT_FLAG_DELAY)
	  e3:SetCode(EVENT_TO_GRAVE)
	  e3:SetCountLimit(1,12992534)
	  e3:SetTarget(c3201004.sptg)
	  e3:SetOperation(c3201004.spop)
	  c:RegisterEffect(e3)
end
function c3201004.synlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x341)
end
function c3201004.cfilter(c,tp)
	return c:IsSetCard(0x341) and c:IsType(TYPE_MONSTER) and not c:IsCode(3201004) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c3201004.filter,tp,LOCATION_DECK,0,1,c)
end
function c3201004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3201004.cfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c3201004.cfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c3201004.filter(c)
	return c:IsSetCard(0x341) and not c:IsCode(3201004) and c:IsAbleToHand()
end
function c3201004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c3201004.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3201004.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c3201004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c3201004.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,12992430)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end