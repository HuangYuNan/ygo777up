--赌上一切の黑白棋
function c20152514.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,20152514)
	e1:SetCost(c20152514.cost)
	e1:SetTarget(c20152514.target)
	e1:SetOperation(c20152514.activate)
	c:RegisterEffect(e1)
			--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152514,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,20152514)
	e2:SetCondition(c20152514.condition)
	e2:SetCost(c20152514.cost2)
	e2:SetTarget(c20152514.target2)
	e2:SetOperation(c20152514.activate2)
	c:RegisterEffect(e2)
end
function c20152514.filter(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c20152514.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152514.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20152514.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20152514.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c20152514.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c20152514.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c20152514.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c20152514.activate2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetOperation(c20152514.disop)
	Duel.RegisterEffect(e1,p)
end
function c20152514.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
end
function c20152514.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152514.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20152514.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end