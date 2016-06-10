--Mapper-Prim
function c37564301.initial_effect(c)
	aux.AddXyzProcedure(c,c37564301.mfilter,12,5)
	c:EnableReviveLimit()
	--spsummon condition
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	e5:SetValue(c37564301.splimit)
	c:RegisterEffect(e5)
	--inv
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetValue(c37564301.efilter)
	c:RegisterEffect(e8)
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_UNRELEASABLE_SUM)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	local e22=e11:Clone()
	e22:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e22)
	local e222=Effect.CreateEffect(c)
	e222:SetType(EFFECT_TYPE_SINGLE)
	e222:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e222:SetRange(LOCATION_MZONE)
	e222:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e222:SetValue(1)
	c:RegisterEffect(e222)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetTarget(c37564301.distg)
	c:RegisterEffect(e3)
	--yaya
	local e88=Effect.CreateEffect(c)
	e88:SetCategory(CATEGORY_REMOVE)
	e88:SetType(EFFECT_TYPE_QUICK_O)
	e88:SetCode(EVENT_FREE_CHAIN)
	e88:SetRange(LOCATION_MZONE)
	e88:SetCountLimit(1)
	e88:SetTarget(c37564301.tgtg)
	e88:SetOperation(c37564301.tgop)
	c:RegisterEffect(e88)
	--removeex
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c37564301.atktg)
	e1:SetOperation(c37564301.atkop)
	c:RegisterEffect(e1)
end
function c37564301.mfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c37564301.splimit(e,se,sp,st)
	local eff=se:GetHandler()
	return (eff:IsCode(37564300) or eff:IsCode(37564013))
end
function c37564301.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c37564301.distg(e,c)
	return c:IsFaceup() and not (c:IsCode(37564301) and c:IsCode(37564300))
end
function c37564301.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_MZONE)
end
function c37564301.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,1-tp,LOCATION_MZONE,0,nil,TYPE_MONSTER)
	if g:GetCount()>0 then
		local tg=g:GetMaxGroup(Card.GetAttack)
		if tg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Remove(sg,POS_FACEUP,REASON_RULE)
		else Duel.Remove(tg,POS_FACEUP,REASON_RULE) end
	end
end
function c37564301.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_EXTRA,0,nil)
	local gc=g:GetCount()
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,gc,tp,LOCATION_EXTRA)
	Duel.SetChainLimit(aux.FALSE)
end
function c37564301.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_EXTRA,0,nil)
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end