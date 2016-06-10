--SAO•亚丝娜
function c20152612.initial_effect(c)
	c:SetUniqueOnField(1,1,20152612)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152612.ovfilter,aux.Stringid(20152612,7),3,nil)
	c:EnableReviveLimit()
		--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c20152612.aclimit)
	e1:SetCondition(c20152612.actcon)
	c:RegisterEffect(e1)
		--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152612,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20152612.negcon)
	e2:SetCost(c20152612.negcost)
	e2:SetTarget(c20152612.negtg)
	e2:SetOperation(c20152612.negop)
	c:RegisterEffect(e2)
		--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetDescription(aux.Stringid(20152612,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20152612.condition)
	e3:SetCost(c20152612.cost)
	e3:SetTarget(c20152612.target)
	e3:SetOperation(c20152612.operation)
	c:RegisterEffect(e3)
end
function c20152612.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c20152612.actcon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152602) and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c20152612.ovfilter(c)
	return c:IsFaceup() and c:IsCode(20152602)
end
function c20152612.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152608)
end
function c20152612.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	Duel.Release(e:GetHandler(),REASON_COST)
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c20152612.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c20152612.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c20152612.tfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xa290) and c:IsType(TYPE_XYZ) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function c20152612.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c20152612.tfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsChainNegatable(ev)
end
function c20152612.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152612.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
end
end
function c20152612.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
