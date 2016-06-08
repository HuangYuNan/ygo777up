--星之少女   星野梦美
function c1103909.initial_effect(c)
   --synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1240),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--tohand
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(1103909,1))
	e5:SetProperty(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1,1103909)
	e5:SetCost(c1103909.thcost)
	e5:SetTarget(c1103909.thtg)
	e5:SetOperation(c1103909.thop)
	c:RegisterEffect(e5)
	--Atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1240))
	e1:SetValue(c1103909.val)
	c:RegisterEffect(e1) 
end
function c1103909.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c1103909.filter(c)
	return c:IsSetCard(0x1240) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c1103909.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c75878039.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1103909.thop(e,tp,eg,ep,ev,re,r,rp)
	 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75878039.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1103909.filter1(c)
	return c:IsSetCard(0x1240) and c:IsType(TYPE_MONSTER)
end
function c1103909.val(e,c)
	return Duel.GetMatchingGroupCount(c1103909.filter1,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*200
end