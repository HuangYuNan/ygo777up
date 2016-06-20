--Eternal Fantasy
require "expansions/script/c37564765"
function c37564512.initial_effect(c)
	senya.nntr(c)
	--Activate(effect)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c37564512.condition2)
	e2:SetCountLimit(1,37564512+EFFECT_COUNT_CODE_OATH)
	e2:SetTarget(c37564512.target2)
	e2:SetOperation(c37564512.activate2)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e1:SetCondition(function(e)
		local tp=e:GetHandlerPlayer()
		return Duel.IsExistingMatchingCard(c37564512.cfilter,tp,LOCATION_MZONE,0,1,nil,true)
	end)
	c:RegisterEffect(e1)
end
function c37564512.cfilter(c,ori)
	return c:IsFaceup() and (c:IsSetCard(0x773) or c:IsCode(37564765)) and (not ori or c:GetOriginalCode()==37564765)
end
function c37564512.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and Duel.IsExistingMatchingCard(c37564512.cfilter,tp,LOCATION_MZONE,0,1,nil,false)
end
function c37564512.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37564512.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
