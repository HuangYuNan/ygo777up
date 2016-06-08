--破灭的绝望
function c23456787.initial_effect(c)
 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23456787+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c23456787.cost)
	e1:SetTarget(c23456787.target3)
	e1:SetOperation(c23456787.activate3)
	c:RegisterEffect(e1)
end
function c23456787.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_WYRM) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_WYRM)
	Duel.Release(g,REASON_COST)
end
function c23456787.cfilter1(c)
	return c:IsFaceup() and c:IsRace(RACE_WYRM)
end
function c23456787.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c23456787.cfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c23456787.filter3(c)
	return c:IsAbleToRemove()
end
function c23456787.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456787.filter3,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c23456787.filter3,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c23456787.activate3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c23456787.filter3,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
