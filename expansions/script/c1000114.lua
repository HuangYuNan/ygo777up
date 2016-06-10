--Ê½Éñ¼§¡¤´º´ýÔÂ
function c1000114.initial_effect(c)
	c:EnableReviveLimit()
	--¢Ú
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c1000114.cost)
	e1:SetTarget(c1000114.target)
	e1:SetOperation(c1000114.activate)
	c:RegisterEffect(e1)
end
function c1000114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)
	and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,nil) end
	Duel.PayLPCost(tp,1000)
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end
function c1000114.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c1000114.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local zsg=Duel.GetOperatedGroup()
	local g=zsg:Filter(c1000114.filter1,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,zsg)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(tp)
	else
		Duel.ConfirmCards(1-tp,zsg)
		Duel.ShuffleHand(tp)
	end
end
function c1000114.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3202) and not c:IsPublic()
end