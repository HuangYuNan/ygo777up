--愿错物·铁桥
function c10960002.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10960002,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCost(c10960002.spcost)
	e1:SetCondition(c10960002.condition)
	e1:SetTarget(c10960002.sptg)
	e1:SetOperation(c10960002.spop)
	c:RegisterEffect(e1)	
end
function c10960002.cfilter(c)
	return c:IsFaceup() and c:IsAbleToHandAsCost()
end
function c10960002.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10960002.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c10960002.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetFirst():IsAttribute(ATTRIBUTE_WIND) then e:SetLabel(1) else e:SetLabel(0) end
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c10960002.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c10960002.filter(c,e,tp)
	return c:IsSetCard(0x357) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10960002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c10960002.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c10960002.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10960002.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
