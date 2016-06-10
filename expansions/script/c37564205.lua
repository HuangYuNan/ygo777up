--Sawawa-Lunatic Sprinter
require "script/c37564765"
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
		if tc and c:IsFaceup() then
			local code=tc:GetOriginalCode()
			local atk=tc:GetBaseAttack()
			local def=tc:GetBaseDefense()
			local cid=0
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetValue(code)
			c:RegisterEffect(e1)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetCode(EFFECT_SET_BASE_ATTACK)
			e3:SetValue(atk)
			c:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			e4:SetCode(EFFECT_SET_BASE_DEFENSE)
			e4:SetValue(def)
			c:RegisterEffect(e4)
			if not tc:IsType(TYPE_TRAPMONSTER) then
				cid=c:CopyEffect(code, RESET_EVENT+0x1fe0000)
			end
		end
end