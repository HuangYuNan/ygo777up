--花妖精·带刺玫瑰
function c10953006.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x2e4),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c10953006.condition)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(10953006,1))
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c10953006.condition)
	e2:SetCost(c10953006.cost)
	e2:SetTarget(c10953006.target)
	e2:SetOperation(c10953006.operation)
	c:RegisterEffect(e2)
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c10953006.recon)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)
end
function c10953006.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0
end
function c10953006.filter2(c)
	return c:IsSetCard(0x2e4) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c10953006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10953006.filter2,tp,LOCATION_REMOVED,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c10953006.filter2,tp,LOCATION_REMOVED,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c10953006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c10953006.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c10953006.recon(e)
	return e:GetHandler():IsFaceup()
end