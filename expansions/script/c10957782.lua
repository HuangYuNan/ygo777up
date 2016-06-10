--Miracle·Untomb
function c10957782.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10957782.thcost)
	e1:SetTarget(c10957782.destg)
	e1:SetOperation(c10957782.desop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetDescription(aux.Stringid(10957782,0))
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c10957782.condtion)
	e2:SetCountLimit(1,10957782)
	e2:SetTarget(c10957782.target2)
	e2:SetOperation(c10957782.operation)
	c:RegisterEffect(e2)	  
end
function c10957782.dfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x239)
end
function c10957782.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957782.dfilter,tp,LOCATION_EXTRA,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10957782.dfilter,tp,LOCATION_EXTRA,0,2,2,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c10957782.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_DECK,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10957782.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c10957782.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10957782.filter(c)
	return c:IsSetCard(0x239) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c10957782.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c10957782.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10957782.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c10957782.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c10957782.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end