--六里雾中 伊吹萃香
function c11200052.initial_effect(c)
	--tdth
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetDescription(aux.Stringid(11200052,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,11252)
	e3:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e3:SetCost(c11200052.cost)
	e3:SetTarget(c11200052.target)
	e3:SetOperation(c11200052.operation)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c11200052.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c11200052.filter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsFaceup() and c:IsSetCard(0x250) and c:IsAbleToDeck() and not c:IsCode(11200052)
end
function c11200052.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c11200052.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,0,0)
end
function c11200052.filter1(c)
	return c:IsFaceup() and c:IsCode(11200058)
end
function c11200052.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c11200052.filter,tp,LOCATION_GRAVE,0,2,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c11200052.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	if og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==2 and Duel.IsExistingMatchingCard(c11200052.filter1,tp,LOCATION_MZONE,0,1,nil) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end