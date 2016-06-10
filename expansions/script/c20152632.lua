--ALO•亚丝娜
function c20152632.initial_effect(c)
	c:SetUniqueOnField(1,1,20152612)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152632.ovfilter,aux.Stringid(20152632,7),3,nil)
	c:EnableReviveLimit()
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c20152632.upcon)
	e1:SetCost(c20152632.upcost)
	e1:SetOperation(c20152632.upop)
	c:RegisterEffect(e1)
		--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152632,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20152632.negcon)
	e2:SetCost(c20152632.negcost)
	e2:SetTarget(c20152632.negtg)
	e2:SetOperation(c20152632.negop)
	c:RegisterEffect(e2)
		--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetDescription(aux.Stringid(20152632,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20152632.condition)
	e3:SetCost(c20152632.cost)
	e3:SetTarget(c20152632.target)
	e3:SetOperation(c20152632.operation)
	c:RegisterEffect(e3)
end
function c20152632.ovfilter(c)
	return c:IsCode(20152602) and c:IsFaceup()
end
	function c20152632.upcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc
and c:GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152602)
end
function c20152632.upcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c20152632.upop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	if a:GetControler()==tp then
		e1:SetValue(d:GetAttack())
		a:RegisterEffect(e1)
	else
		e1:SetValue(a:GetAttack())
		d:RegisterEffect(e1)
	end
end
function c20152632.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152608)
end
function c20152632.cost(e,tp,eg,ep,ev,re,r,rp,chk)
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
function c20152632.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c20152632.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c20152632.negcon(e,tp,eg,ep,ev,re,r,rp)
	if (not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE))
		or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c20152632.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152632.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c20152632.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end