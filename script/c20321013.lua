require "script/c20329999"
function c20321013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(20321013,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCost(Mfrog.skdqcost)
	e2:SetTarget(c20321013.target)
	e2:SetOperation(c20321013.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c20321013.con)
	e3:SetOperation(c20321013.op)
	c:RegisterEffect(e3)
end
function c20321013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20321013.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20321013.filter(c)
	return c:IsSetCard(0x281) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c20321013.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20321013.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20321013.filter2(c)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsControler(1-c:GetOwner()) and c:IsSetCard(0x281) and c:IsType(TYPE_MONSTER)
end
function c20321013.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:IsExists(c20321013.filter2,1,nil)
end
function c20321013.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,20321013)
	Duel.Damage(1-tp,800,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,800,REASON_EFFECT)
end