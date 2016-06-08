--夜晚的小鬼 伊吹萃香
function c11200055.initial_effect(c)
	--th
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11200055,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c11200055.tg)
	e1:SetOperation(c11200055.op)
	c:RegisterEffect(e1)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(c11200055.tar)
	e3:SetValue(400)
	c:RegisterEffect(e3)
end
function c11200055.filter(c)
	return c:IsCode(11200055) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c11200055.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11200055.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11200055.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11200055.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c11200055.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x250) and c:IsType(TYPE_MONSTER)
end
function c11200055.tar(e,c)
	local g=Duel.GetMatchingGroup(c11200055.atkfilter,tp,LOCATION_MZONE,0,nil):GetMaxGroup(Card.GetAttack)
	return g:IsContains(c)
end