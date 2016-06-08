--GGO•桐子
function c20152621.initial_effect(c)
	c:SetUniqueOnField(1,1,20152611)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152621.ovfilter,aux.Stringid(20152621,7),3,nil)
	c:EnableReviveLimit()
					--in
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c20152621.condition2)
	e1:SetTarget(c20152621.atktarget)
	c:RegisterEffect(e1)
		--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152621,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c20152621.negcon)
	e2:SetCost(c20152621.negcost)
	e2:SetTarget(c20152621.negtg)
	e2:SetOperation(c20152621.negop)
	c:RegisterEffect(e2)
end
function c20152621.ovfilter(c)
	return c:IsCode(20152601) and c:IsFaceup()
end
function c20152621.atktarget(e,c)
	return c:GetAttack()<=2800
end
function c20152621.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152601)
end
function c20152621.negcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_EFFECT) and re:IsHasType(EFFECT_TYPE_ACTIONS) and Duel.IsChainNegatable(ev)
end
function c20152621.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152621.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
end
end
function c20152621.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
