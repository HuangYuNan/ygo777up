--空母ヲ级
function c233588.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,0x2),aux.NonTuner(Card.IsRace,0x20),1)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233588,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c233588.condition)
	e1:SetTarget(c233588.target)
	e1:SetOperation(c233588.operation)
	c:RegisterEffect(e1)
end
function c233588.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c233588.filter(c)
	return c:IsType(0x6) and c:IsAbleToRemove()
end
function c233588.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c233588.filter,tp,0xc,0xc,1,nil) end
	local g=Duel.GetMatchingGroup(c233588.filter,tp,0xc,0xc,nil) 
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c233588.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c233588.filter,tp,0xc,0xc,nil) 
	if g:GetCount()>0 then
		Duel.Remove(g,0x5,0x40)
	end
end