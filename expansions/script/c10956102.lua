--星占之巫女·小忆·晨
function c10956102.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WATER),1)
	c:EnableReviveLimit()
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10956102,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,10956102)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c10956102.spcost)
	e2:SetTarget(c10956102.sptg)
	e2:SetOperation(c10956102.spop)
	c:RegisterEffect(e2)
	--Attribute Dark
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_ATTRIBUTE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(ATTRIBUTE_WATER)
	c:RegisterEffect(e4)	 
end
function c10956102.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToGraveAsCost()
end
function c10956102.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10956102.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c10956102.cfilter,1,1,REASON_COST,e:GetHandler())
end
function c10956102.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10956102.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10956102.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c10956102.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10956102.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
