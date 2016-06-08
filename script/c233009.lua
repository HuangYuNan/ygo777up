--金鱼之舞
function c233009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233009,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCost(c233009.cost)
	e1:SetCondition(c233009.condition)
	e1:SetTarget(c233009.target)
	e1:SetOperation(c233009.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(233009,1))
	e2:SetCondition(c233009.descon)
	e2:SetTarget(aux.TRUE)
	e2:SetOperation(c233009.desop)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetDescription(aux.Stringid(233009,2))
	e3:SetTarget(aux.TRUE)
	e3:SetOperation(c233009.damop)
	c:RegisterEffect(e3)
end
function c233009.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,1500,REASON_EFFECT)
end

function c233009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c233009.filter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
end
function c233009.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsActiveType(TYPE_MONSTER) and eg:IsExists(c233009.filter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c233009.descon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsActiveType(TYPE_MONSTER) and eg:IsExists(c233009.filter,1,nil,tp) and Duel.IsChainDisablable(ev)
	and not re:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c233009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c233009.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if tc:IsFaceup() and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2)
	end
end
function c233009.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if tc:IsFaceup() and tc:IsDestructable() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end