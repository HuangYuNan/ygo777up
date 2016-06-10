--神姬憎物
function c1000122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c1000122.cost)
	e1:SetTarget(c1000122.target)
	e1:SetOperation(c1000122.activate)
	c:RegisterEffect(e1)
end
function c1000122.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000122.filter,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,c1000122.filter,2,2,REASON_COST+REASON_DISCARD)
end
function c1000122.filter(c)
	return c:IsSetCard(0x3202) and c:IsDiscardable() and c:IsType(TYPE_MONSTER)
end
function c1000122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c1000122.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local zsg=Duel.GetOperatedGroup()
	local g=zsg:Filter(c1000122.filter1,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,zsg)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(tp)
	else
		Duel.ConfirmCards(1-tp,zsg)
		Duel.ShuffleHand(tp)
	end
end
function c1000122.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3202) and not c:IsPublic()
end
