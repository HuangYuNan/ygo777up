--被遗忘者的丰碑
function c23310011.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c23310011.target)
	e1:SetOperation(c23310011.activate)
	c:RegisterEffect(e1)
end
function c23310011.tdfilter(c)
	return c:IsFacedown() and c:IsAbleToDeck()
end
function c23310011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23310011.tdfilter,tp,LOCATION_REMOVED,0,1,nil) end
	local g=Duel.GetMatchingGroup(c23310011.tdfilter,tp,LOCATION_REMOVED,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c23310011.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23310011.tdfilter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)
		if ct>2 then ct=2 end
		if ct>0 then
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	end
end