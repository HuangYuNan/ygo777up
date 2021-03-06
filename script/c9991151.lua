--Kozilek, the Great Distortion
require "expansions/script/c9990000"
function c9991151.initial_effect(c)
	c:SetUniqueOnField(1,0,9991151,LOCATION_MZONE)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,12,function(e,tp)
		if not Duel.IsPlayerCanDraw(tp) then return end
		local drc=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if drc<=0 then return end
		Duel.Draw(tp,drc,REASON_RULE)
	end)
	--Counter Spell & Trap
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,1,1,nil)
		Duel.Remove(rg,POS_FACEUP,REASON_COST)
	end)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
			and ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
		if re:GetHandler():IsAbleToRemove() and re:GetHandler():IsRelateToEffect(re) then
			Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
		end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
	--Counter Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,1,1,nil)
		Duel.Remove(rg,POS_FACEUP,REASON_COST)
	end)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetCurrentChain()==0
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local ag=eg:Filter(function(c) return c:GetSummonPlayer()~=tp end,nil,tp)
		if chk==0 then return ag:GetCount()>0 end
		Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,ag,ag:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,ag,ag:GetCount(),0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local ag=eg:Filter(function(c) return c:GetSummonPlayer()~=tp end,nil,tp)
		Duel.NegateSummon(ag)
		Duel.Remove(ag,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end