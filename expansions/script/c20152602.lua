--结城明日奈
function c20152602.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152602,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20152602)
	e1:SetCondition(c20152602.discon)
	e1:SetCost(c20152602.discost)
	e1:SetTarget(c20152602.distg)
	e1:SetOperation(c20152602.disop)
	c:RegisterEffect(e1)
		--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(20152602,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,20152602)
	e2:SetTarget(c20152602.sptg)
	e2:SetOperation(c20152602.spop)
	c:RegisterEffect(e2)
end
function c20152602.sdfilter(c)
	return not c:IsSetCard(0xa290)
end
function c20152602.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_EFFECT) and re:IsHasType(EFFECT_TYPE_ACTIONS) and Duel.IsChainNegatable(ev) and not Duel.IsExistingMatchingCard(c20152602.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c20152602.filter7(c)
	return c:IsSetCard(0xa290)
and c:IsAbleToRemoveAsCost()
end
function c20152602.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable()
		and Duel.IsExistingMatchingCard(c20152602.filter7,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c20152602.filter7,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c20152602.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c20152602.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c20152602.filter(c,e,tp)
	return c:IsSetCard(0xa290) and not c:IsCode(20152602) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20152602.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20152602.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c20152602.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152602.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
