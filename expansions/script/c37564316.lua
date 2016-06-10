--帕拉诺尼亚·奏
function c37564316.initial_effect(c)
	--publics
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_ATTACK)
	end)
	e4:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	e5:SetValue(0)
	c:RegisterEffect(e5)
--effects
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(37564316,1))
	e6:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCountLimit(1,37564316)
	e6:SetTarget(c37564316.target1)
	e6:SetOperation(c37564316.operation1)
	c:RegisterEffect(e6)
end
function c37564316.rmfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsAbleToDeck()
end
function c37564316.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564316.rmfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c37564316.rmfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c37564316.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c37564316.rmfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end