--邪神姬·先胜
function c1000110.initial_effect(c)
	c:EnableReviveLimit()
	--Dis
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetDescription(aux.Stringid(30646525,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c1000110.condition)
	e1:SetOperation(c1000110.operation)
	c:RegisterEffect(e1)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCost(c1000110.thcost)
	e1:SetCondition(c1000110.condition)
	e1:SetTarget(c1000110.target)
	e1:SetOperation(c1000110.activate)
	c:RegisterEffect(e1)
end
function c1000110.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL
end
function c1000110.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
end
function c1000110.cfilter(c)
	return c:IsSetCard(0x5202) and c:IsAbleToDeckAsCost()
end
function c1000110.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1000110.bfilter(chkc,e,tp) end
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost()
		and Duel.IsExistingMatchingCard(c1000110.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c1000110.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c1000110.condition(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local s=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	return tp==Duel.GetTurnPlayer() and t>s
end
function c1000110.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local s=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,t-s) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(t-s)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,t-s)
end
function c1000110.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local t=Duel.GetFieldGroupCount(p,0,LOCATION_HAND)
	local s=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if t>s then
		Duel.Draw(p,t-s,REASON_EFFECT)
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end