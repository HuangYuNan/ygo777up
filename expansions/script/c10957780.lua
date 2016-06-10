--Miracle·Stateline
function c10957780.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10957780.thcost)
	e1:SetCountLimit(1,10957780)
	e1:SetTarget(c10957780.target)
	e1:SetOperation(c10957780.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(10957780,0))
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c10957780.condtion)
	e2:SetCountLimit(1,10957780)
	e2:SetTarget(c10957780.target2)
	e2:SetOperation(c10957780.operation)
	c:RegisterEffect(e2)	
end
function c10957780.dfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x239)
end
function c10957780.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957780.dfilter,tp,LOCATION_EXTRA,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10957780.dfilter,tp,LOCATION_EXTRA,0,2,2,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c10957780.filter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x239) and c:IsAbleToHand()
end
function c10957780.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957780.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10957780.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10957780.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	local tc=e:GetHandler()
		Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10957780,0))
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(tp,1)
	end
end
end
function c10957780.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10957780.filter2(c)
	return c:IsSetCard(0x239) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c10957780.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957780.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10957780.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10957780.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end