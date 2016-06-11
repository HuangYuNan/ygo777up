--Sawawa-Lunatic Sprinter
if not senya then local io=require('io') local chk=io.open("expansions/script/c37564765.lua","r") if chk then chk:close() require "expansions/script/c37564765" else require "script/c37564765" end end
function c37564205.initial_effect(c)
local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(senya.swwblex)
	e1:SetTarget(c37564205.atktg)
	e1:SetOperation(c37564205.atkop)
	c:RegisterEffect(e1)
	senya.sww(c,2,true,false,true)
end
function c37564205.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564205.rmfilter,tp,0,LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c37564205.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function c37564205.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c37564205.rmfilter,tp,0,LOCATION_EXTRA,nil)
	if g:GetCount()==0 then return end
	local gc=g:RandomSelect(tp,1):GetFirst()
	Duel.Remove(gc,POS_FACEUP,REASON_EFFECT)
		local tc=Duel.GetOperatedGroup():GetFirst()
		senya.copy(e,nil,tc)
end