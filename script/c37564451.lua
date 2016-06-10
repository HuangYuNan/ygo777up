--百慕 冲击的相遇·莉普丝
require "/expansions/script/c37564765"
function c37564451.initial_effect(c)
	senya.bm(c)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564451,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(senya.bmsscon)
	e3:SetTarget(c37564451.target)
	e3:SetOperation(c37564451.operation)
	c:RegisterEffect(e3)
end
function c37564451.filter(c)
	return senya.bmchkfilter(c) and c:IsAbleToHand()
end
function c37564451.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564401.filter,tp,LOCATION_DECK,0,1,nil) and e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c37564451.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c37564401.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		if Duel.SendtoHand(g,nil,REASON_EFFECT)>0 and e:GetHandler():IsRelateToEffect(e) then
			Duel.ConfirmCards(1-tp,g)
			Duel.ShuffleDeck(tp)
			Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
		end
	end
end
