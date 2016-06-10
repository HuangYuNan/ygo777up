--星之祈愿  星野梦美
function c1103911.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon from hand
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c1103911.hspcon)
	e1:SetOperation(c1103911.hspop)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c1103911.condition)
	e1:SetTarget(c1103911.target)
	e1:SetOperation(c1103911.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1103911,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c1103911.spcost)
	e2:SetTarget(c1103911.sptg)
	e2:SetOperation(c1103911.spop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetTarget(c1103911.thtg)
	e3:SetOperation(c1103911.thop)
	c:RegisterEffect(e3)
end
function c1103911.rfilter1(c,tp)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c1103911.rfilter2,tp,LOCATION_GRAVE,0,1,c)
end
function c1103911.rfilter2(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToRemoveAsCost()
end
function c1103911.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1103911.rfilter1,tp,LOCATION_GRAVE,0,1,nil,tp)
end
function c1103911.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c1103911.rfilter1,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c1103911.rfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c1103911.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c1103911.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x1240) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1103911.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c1103911.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1103911.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1103911.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1103911.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1103911.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c1103911.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c1103911.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1103911.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1103911.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1103911.spop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsEnvironment(56433456) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1103911.filter1(c)
	return  c:IsAbleToHand()
end
function c1103911.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1103911.filter1,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c1103911.filter1,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c1103911.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1103911.filter1,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end