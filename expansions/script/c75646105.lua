--普勒阿得斯会长
function c75646105.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1,75646105)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c75646105.condition)
	e1:SetCost(c75646105.cost)
	e1:SetTarget(c75646105.target)
	e1:SetOperation(c75646105.operation)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,75646105)
	e2:SetCondition(c75646105.condition1)
	e2:SetCost(c75646105.cost1)
	e2:SetTarget(c75646105.target1)
	e2:SetOperation(c75646105.operation1)
	c:RegisterEffect(e2)
end
function c75646105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c75646105.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c75646105.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c0) and c:IsType(TYPE_MONSTER)
end
function c75646105.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75646105.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646105.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c75646105.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75646105.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c75646105.efilter)
		tc:RegisterEffect(e2)
	end
end
function c75646105.efilter(e,te)
	return not te:GetOwner():IsSetCard(0x2c0)
end
function c75646105.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c75646105.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c75646105.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2c0) and c:IsType(TYPE_MONSTER)
end
function c75646105.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75646105.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75646105.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c75646105.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75646105.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(0,1)
		e1:SetCondition(c75646105.actcon)
		e1:SetValue(c75646105.aclimit)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c75646105.actcon(e)
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and (c:GetBattleTarget()~=nil or c:GetBattleTarget()==nil)
		and e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c75646105.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end