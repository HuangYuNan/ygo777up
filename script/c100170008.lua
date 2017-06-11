--hongfengsanluo
function c100170008.initial_effect(c)
	aux.AddSynchroProcedure(c,c100170008.tfilter,aux.NonTuner(Card.IsSetCard,0x5cd),1)
	c:EnableReviveLimit()
	--cannot Disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c100170008.infilter)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetOperation(c100170008.operation)
	c:RegisterEffect(e3)
end
function c100170008.tfilter(c)
	return c:IsSetCard(0x5cd)
end
function c100170008.infilter(e,c)
	return c:IsType(TYPE_SPELL) and c:IsFaceup()
end
function c100170008.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5cd) and c:IsAbleToHand()
end
function c100170008.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100170008.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
end