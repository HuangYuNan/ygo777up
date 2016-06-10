--奇犽的生日礼物
function c23400005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23400005+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c23400005.cost)
	e1:SetTarget(c23400005.target)
	e1:SetOperation(c23400005.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c23400005.reptg)
	e2:SetValue(c23400005.repval)
	e2:SetOperation(c23400005.repop)
	c:RegisterEffect(e2)
end
---
function c23400005.filter(c)
	return c:IsSetCard(0x530) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c23400005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23400005.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c23400005.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c23400005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c23400005.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
------
function c23400005.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x530)  and c:IsLocation(LOCATION_ONFIELD)
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c23400005.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c23400005.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(23400005,0))
end
function c23400005.repval(e,c)
	return c23400005.repfilter(c,e:GetHandlerPlayer())
end
function c23400005.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
