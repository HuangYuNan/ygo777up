--五月七日茴香
function c20152208.initial_effect(c)
--huishou
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152208,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,20152208)
	e1:SetCost(c20152208.cost)
	e1:SetTarget(c20152208.target)
	e1:SetOperation(c20152208.operation)
	c:RegisterEffect(e1)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152208,1)) 
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_HAND)
	e4:SetCountLimit(1,20152208)
	e4:SetCost(c20152208.thcost)
	e4:SetTarget(c20152208.thtg)
	e4:SetOperation(c20152208.thop)
	c:RegisterEffect(e4)
end
function c20152208.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c20152208.thfilter(c)
	return c:IsSetCard(0x3290) and c:IsType(TYPE_MONSTER) and not c:IsCode(20152208) and c:IsAbleToHand()
end
function c20152208.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152208.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20152208.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20152208.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20152208.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()and Duel.IsExistingTarget(c20152208.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c20152208.filter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x3290) and not c:IsCode(20152208)
end
function c20152208.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c20152208.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152208.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20152208.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20152208.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
