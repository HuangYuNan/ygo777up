--Barrage Tyrant
require "expansions/script/c9990000"
function c9991133.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Damage or Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(function(e)
		e:SetLabel(1)
		return true
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local fil=function(c)
			return c:IsRace(RACE_REPTILE) and c:IsAttackAbove(0) and c:IsAbleToRemoveAsCost()
		end
		if chk==0 then
			if e:GetLabel()==1 then e:SetLabel(0) return true else return false end
		end
		e:SetLabel(0)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,fil,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetTargetParam(rg:GetFirst():GetAttack())
		Duel.Remove(rg,POS_FACEUP,REASON_COST)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
		local dg=Duel.GetMatchingGroup(function(c,d)
			return c:IsFaceup() and c:IsDestructable() and c:IsDefenseBelow(d)
		end,tp,0,LOCATION_MZONE,nil,d)
		if dg:GetCount()==0 or Duel.SelectOption(tp,aux.Stringid(9991133,0),aux.Stringid(9991133,1))==1 then
			Duel.Damage(1-tp,d,REASON_EFFECT)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			dg=dg:Select(tp,1,1,nil)
			Duel.HintSelection(dg)
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
end