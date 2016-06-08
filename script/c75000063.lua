--神之曲 营休之章
function c75000063.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75000063)
	e1:SetCost(c75000063.cost)
	e1:SetTarget(c75000063.target)
	e1:SetOperation(c75000063.activate)
	c:RegisterEffect(e1)
end
function c75000063.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000063.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75000063.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,tp,0)
end
function c75000063.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c75000063.filter(c)
	return c:IsSetCard(0x52f) and c:IsAbleToRemoveAsCost() and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_PENDULUM))
end
function c75000063.filter2(c)
	return c:IsSetCard(0x52f) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER) 
end
function c75000063.filter3(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM)
end
function c75000063.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TARGET_PARAM)
	local ct=Duel.Draw(p,d,REASON_EFFECT)
	if ct==0 then return end
	local dc=Duel.GetOperatedGroup():GetFirst()
	if dc:IsSetCard(0x52f) and Duel.IsExistingMatchingCard(c75000063.filter3,tp,LOCATION_DECK,0,1,nil,e,tp) and (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil or Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) and dc:IsType(TYPE_MONSTER) then
		if Duel.SelectYesNo(tp,aux.Stringid(75000063,0)) then
			Duel.BreakEffect()
			Duel.ConfirmCards(1-tp,dc)
			local g=Duel.SelectMatchingCard(tp,c75000063.filter3,tp,LOCATION_DECK,0,1,1,nil,tp)
			local tc=g:GetFirst()
			if tc then
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			end
		end
	end
end