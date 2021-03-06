--プライマル・ネクサス
require "expansions/script/c9990000"
function c9991980.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Ignition
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c9991980.target)
	e2:SetOperation(c9991980.operation)
	c:RegisterEffect(e2)
	--Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_DRAGON+RACE_WYRM))
	e3:SetValue(300)
	c:RegisterEffect(e3)
	--Scale
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_RSCALE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_SZONE,0)
	e4:SetValue(c9991980.scalevalue)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_LSCALE)
	c:RegisterEffect(e5)
end
function c9991980.scalevalue(e,c)
	if c:GetSequence()<6 then return 0 end
	local val=0
	if Dazz.IsInheritor(c,nil,1) then val=val-1 end
	if Dazz.IsInheritor(c,nil,2) then val=val+1 end
	return val
end
function c9991980.filter1(c,tp)
	return Dazz.IsInheritor(c) and c:IsType(TYPE_PENDULUM) and c:IsAbleToGrave()
		and (not tp or Duel.IsExistingMatchingCard(Dazz.IsInheritor,tp,LOCATION_DECK,0,1,c))
end
function c9991980.filter2(c,e,tp)
	return Dazz.IsInheritor(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9991980.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c9991980.filter1,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c9991980.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(c9991980.filter1,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=g1:Select(tp,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991980,0))
		local sg=Duel.SelectMatchingCard(tp,Dazz.IsInheritor,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoExtraP(sg,nil,REASON_EFFECT)
	end
end