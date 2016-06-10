--邪王真眼
function c20152211.initial_effect(c)
c:SetUniqueOnField(1,0,20152211)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x3290),1)
	c:EnableReviveLimit()
--xiaoshou
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,20152211)
	e1:SetCost(c20152211.cost)
	e1:SetTarget(c20152211.target)
	e1:SetOperation(c20152211.operation)
	c:RegisterEffect(e1)
	end
function c20152211.filter(c)
	return c:IsSetCard(0x3290) and c:IsDiscardable()
end
function c20152211.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152211.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20152211.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20152211.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c20152211.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_DISCARD)
		local sg=g:Select(p,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(1-p)
	end
end
