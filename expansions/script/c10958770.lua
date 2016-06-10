--弧光圣气
function c10958770.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c10958770.condition)
	e1:SetCost(c10958770.cost)
	e1:SetTarget(c10958770.target)
	e1:SetOperation(c10958770.activate)
	c:RegisterEffect(e1)
end
function c10958770.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c10958770.costfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN)
end
function c10958770.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c10958770.costfilter,4,nil) end
	local g=Duel.SelectReleaseGroup(tp,c10958770.costfilter,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c10958770.filter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c10958770.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c10958770.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10958770.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c10958770.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10958770.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(3)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
