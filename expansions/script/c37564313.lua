--帕拉诺尼亚·一
function c37564313.initial_effect(c)
--publics
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
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
	   local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564313,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,37564313)
	e1:SetTarget(c37564313.target)
	e1:SetOperation(c37564313.operation)
	c:RegisterEffect(e1)	
end
function c37564313.filter(c,e)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c37564313.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c37564313.filter(chkc,e) end
	if chk==0 then return Duel.IsExistingTarget(c37564313.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c37564313.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c37564313.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end