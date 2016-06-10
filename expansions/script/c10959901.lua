--曙光之少女 紫苑
function c10959901.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10959901,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c10959901.condition)
	e1:SetCost(c10959901.cost)
	e1:SetTarget(c10959901.target)
	e1:SetOperation(c10959901.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCondition(c10959901.condition2)
	c:RegisterEffect(e2)
end
function c10959901.condition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DISABLE)
	return Duel.GetTurnPlayer()==tp and ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c10959901.condition2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_NEGATE)
	return Duel.GetTurnPlayer()==tp and ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c10959901.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c10959901.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
	end
end
function c10959901.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateActivation(ev) then return end
	if re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
