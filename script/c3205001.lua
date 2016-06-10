--驱魔者 亚连
function c3205001.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,3205001)
	e1:SetTarget(c3205001.target1)
	e1:SetOperation(c3205001.operation1)
	c:RegisterEffect(e1)
	--ignition
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3205001,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,3205001)
	e2:SetTarget(c3205001.target)
	e2:SetOperation(c3205001.operation)
	c:RegisterEffect(e2)
end
function c3205001.filter1(c)
	return c:IsSetCard(0x340) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c3205001.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3205001.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c3205001.operation1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3205001.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c3205001.filter(c)
	return (c:IsOnField() and c:IsFacedown()) or (c:IsLocation(LOCATION_HAND) and not c:IsPublic())
end
function c3205001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3205001.filter,tp,0,LOCATION_HAND+LOCATION_ONFIELD,1,nil) end
	Duel.SetChainLimit(c3205001.chlimit)
end
function c3205001.chlimit(e,ep,tp)
	return tp==rp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c3205001.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c3205001.filter,tp,0,LOCATION_HAND+LOCATION_ONFIELD,nil)
	Duel.ConfirmCards(tp,g)
	Duel.ShuffleHand(1-tp)
end