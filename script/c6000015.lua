--藏书屋·黑白大盗
function c6000015.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x300),3,2)
	c:EnableReviveLimit()
	--return to deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,6000015)
	e1:SetCondition(c6000015.condition)
	e1:SetOperation(c6000015.operation)
	e1:SetDescription(aux.Stringid(6000015,0))
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6000015,1))
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,6215)
	e2:SetCost(c6000015.cost1)
	e2:SetTarget(c6000015.target1)
	e2:SetOperation(c6000015.operation1)
	c:RegisterEffect(e2)
end
function c6000015.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c6000015.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoHand(sg,tp,REASON_EFFECT)
	Duel.SelectOption(1-tp,aux.Stringid(6000015,0))
	Duel.SelectOption(tp,aux.Stringid(6000015,0))
	Duel.Hint(HINT_CARD,0,6000015)
	Duel.ShuffleHand(1-tp)
end
function c6000015.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c6000015.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c6000015.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0,nil)
	local sg=g:RandomSelect(1-tp,1)
	Duel.SelectOption(1-tp,aux.Stringid(6000015,1))
	Duel.SelectOption(tp,aux.Stringid(6000015,1))
	Duel.Hint(HINT_CARD,1,6000015)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end