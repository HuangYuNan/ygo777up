--巫噬天惩
function c10958766.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c10958766.condition)
	e1:SetCost(c10958766.cost)
	e1:SetTarget(c10958766.target)
	e1:SetOperation(c10958766.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c10958766.handcon)
	c:RegisterEffect(e2)  
end
function c10958766.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c10958766.handcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10958766.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c10958766.condition(e,tp,eg,ep,ev,re,r,rp,chk)
    return re~=e and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
        and re:IsActiveType(TYPE_MONSTER) and (re:IsActiveType(TYPE_XYZ) or re:IsActiveType(TYPE_RITUAL) or re:IsActiveType(TYPE_SYNCHRO) 
		or re:IsActiveType(TYPE_FUSION)) and Duel.IsChainNegatable(ev)
end
function c10958766.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c10958766.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c10958766.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEDOWN,REASON_EFFECT)
	end
end
