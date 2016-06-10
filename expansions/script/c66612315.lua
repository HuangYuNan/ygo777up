--赌博与戏法的物语
function c66612315.initial_effect(c)
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_TOGRAVE)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCountLimit(1,66612315)
	e0:SetOperation(c66612315.activate)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x660))
	c:RegisterEffect(e1)
end
function c66612315.filter(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c66612315.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c66612315.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(66612315,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,2,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end