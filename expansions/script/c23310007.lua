--世界创生
function c23310007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c23310007.target)
	e1:SetOperation(c23310007.activate)
	c:RegisterEffect(e1)
end
function c23310007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_DECK,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_DECK)
end
function c23310007.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,1)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
end