--quesar
require "script/c37564765"
function c37564032.initial_effect(c)
	aux.AddXyzProcedure(c,nil,6,4,c37564032.ovfilter,aux.Stringid(37564032,0),5)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c37564032.atkcon)
	e1:SetOperation(c37564032.atkop)
	c:RegisterEffect(e1)
end
function c37564032.ovfilter(c)
	return c:IsFaceup() and c:GetOriginalCode()==37564022 and Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c37564032.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,e:GetHandler(),TYPE_MONSTER)
end
function c37564032.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,e:GetHandler(),TYPE_MONSTER) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,Card.IsType,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,e:GetHandler(),TYPE_MONSTER)
		Duel.Remove(sg,POS_FACEUP,REASON_RULE)
		local tc=sg:GetFirst()
		senya.copy(e,nil,tc,true)
end