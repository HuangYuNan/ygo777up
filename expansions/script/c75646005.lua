--斯巴达二期 Frederic
function c75646005.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75646005,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c75646005.atktg)
	e1:SetOperation(c75646005.atkop)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646005,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1)
	e2:SetCondition(c75646005.condition)
	e2:SetTarget(c75646005.target)
	e2:SetOperation(c75646005.operation)
	c:RegisterEffect(e2)
end
function c75646005.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x2c1)
end
function c75646005.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75646005.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646005.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c75646005.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75646005.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2c1)
end
function c75646005.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetMatchingGroupCount(c75646005.filter1,tp,LOCATION_ONFIELD,0,nil)
	if ct>0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*300)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c75646005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c75646005.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x2c1) and not c:IsHasEffect(EFFECT_DIRECT_ATTACK)
end
function c75646005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75646005.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646005.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c75646005.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75646005.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end