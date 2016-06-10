--QP
function c20320013.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20320013.cost)
	e2:SetTarget(c20320013.target)
	e2:SetOperation(c20320013.op)
	c:RegisterEffect(e2)
end
function c20320013.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsDiscardable()
end
function c20320013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320013.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20320013.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20320013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c20320013.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end