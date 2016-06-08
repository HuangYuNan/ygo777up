--ÑÝ×àÕß ¼ªËû
function c3200001.initial_effect(c)	
--synchro limit
local e1=Effect.CreateEffect(c)
	  e1:SetType(EFFECT_TYPE_SINGLE)
	  e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	  e1:SetValue(c3200001.synlimit)
	  c:RegisterEffect(e1)
--Activate
local e2=Effect.CreateEffect(c)
      e2:SetDescription(aux.Stringid(3200001,0))
	  e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	  e2:SetType(EFFECT_TYPE_IGNITION)
	  e2:SetCountLimit(1,3200001)
	  e2:SetRange(LOCATION_MZONE)
	  e2:SetCost(c3200001.cost)
	  e2:SetTarget(c3200001.target)
	  e2:SetOperation(c3200001.activate)
	  c:RegisterEffect(e2)	
--token
local e3=Effect.CreateEffect(c)
	  e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	  e3:SetProperty(EFFECT_FLAG_DELAY)
	  e3:SetCode(EVENT_TO_GRAVE)
	  e3:SetCountLimit(1,12992531)
	  e3:SetTarget(c3200001.sptg)
	  e3:SetOperation(c3200001.spop)
	  c:RegisterEffect(e3)
end
function c3200001.synlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x341)
end
function c3200001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c3200001.filter(c)
	return c:IsSetCard(0x341) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(3200001)
end
function c3200001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3200001.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c3200001.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3200001.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c3200001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c3200001.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,12993430,0x341,0x4011,0,0,3,RACE_SPELLCASTER,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,12992430)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end