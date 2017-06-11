--星薙·希望
function c10960010.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c10960010.cost)
	e2:SetTarget(c10960010.settg)
	e2:SetOperation(c10960010.setop)
	c:RegisterEffect(e2)   
end
function c10960010.setfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x357)
end
function c10960010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c10960010.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10960010.setfilter,tp,LOCATION_DECK,0,2,nil) end
end
function c10960010.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10960010,2))
	local g=Duel.SelectMatchingCard(tp,c10960010.setfilter,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoExtraP(g,nil,REASON_EFFECT)
	end
end