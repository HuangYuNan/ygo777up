--��֮���  ¶ά
function c1101110.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1101110+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c1101110.target)
	e1:SetOperation(c1101110.activate)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1241))
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c1101110.value)
	c:RegisterEffect(e2)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c1101110.target1)
	e1:SetValue(c1101110.valcon)
	c:RegisterEffect(e1)
end
function c1101110.filter(c)
	return c:IsSetCard(0x6241) and c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c1101110.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101110.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c1101110.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1101110.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1101110.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1241) and c:IsType(TYPE_MONSTER)
end
function c1101110.value(e,c)
	return Duel.GetMatchingGroupCount(c1101110.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*200
end
function c1101110.target1(e,c)
	return c:IsSetCard(0x1241) and c:IsType(TYPE_MONSTER)
end
function c1101110.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0 
end