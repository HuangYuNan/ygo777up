--Nanahira & Halozy
require "expansions/script/c37564765"
function c37564505.initial_effect(c)
	senya.nnhr(c)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564765,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1,37560505)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCost(senya.discost(2))
	e4:SetTarget(senya.swwsstg)
	e4:SetOperation(senya.swwssop)
	c:RegisterEffect(e4)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564505,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,37561505)
	e1:SetTarget(c37564505.target)
	e1:SetOperation(c37564505.operation)
	c:RegisterEffect(e1)
end
function c37564505.filter(c)
	return (c:IsCode(37564765) or c:IsHasEffect(37564765)) and c:IsAbleToHand()
end
function c37564505.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564505.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c37564505.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c37564505.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end