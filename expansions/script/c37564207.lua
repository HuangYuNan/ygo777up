--Sawawa-Koishi Circulation
require "script/c37564765"
function c37564207.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564207,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,37564207)
	e1:SetCondition(senya.swwblex)
	e1:SetCost(senya.swwrmcost(1))
	e1:SetTarget(c37564207.tg)
	e1:SetOperation(c37564207.op)
	c:RegisterEffect(e1)
senya.sww(c,2,true,false,false)
end
function c37564207.effilter(c)
	return c:IsSetCard(0x773)
end
function c37564207.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c37564207.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c37564207.effilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if ct==0 then return end
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if hg:GetCount()==0 then return end
	Duel.ConfirmCards(tp,hg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=hg:Select(tp,1,ct,nil)
	local g=sg:GetCount()
	local dr=g-1
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
	Duel.ShuffleDeck(1-tp)
	if dr>0 then
		Duel.BreakEffect()
		Duel.Draw(1-tp,dr,REASON_EFFECT)
	end
end