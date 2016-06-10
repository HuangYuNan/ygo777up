--奇迹小镇-冈崎汐
function c1001009.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,1001008,aux.FilterBoolFunction(Card.IsSetCard,0x9204),2,true,false)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(c1001009.splimit)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1001009,1))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e3:SetCountLimit(1)
	e3:SetCondition(c1001009.condition)
	e3:SetCost(c1001009.cost)
	e3:SetTarget(c1001009.target)
	e3:SetOperation(c1001009.operation)
	c:RegisterEffect(e3)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1001009,2))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,1001009,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c1001009.descon)
	e1:SetCost(c1001009.descost)
	e1:SetTarget(c1001009.destg)
	e1:SetOperation(c1001009.desop)
	c:RegisterEffect(e1)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1001009,3))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,1001009,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c1001009.descon)
	e1:SetCost(c1001009.descost)
	e1:SetTarget(c1001009.rmtg)
	e1:SetOperation(c1001009.rmop)
	c:RegisterEffect(e1)
end
function c1001009.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c1001009.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c1001009.cfilter(c)
	return c:IsSetCard(0x9204) and c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c1001009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1001009.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c1001009.cfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c1001009.filter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and not (c:GetAttack()==0 and c:IsDisabled())
end
function c1001009.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1001009.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1001009.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c1001009.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c1001009.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		tc:RegisterEffect(e2)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e4)
		end
	end
end
function c1001009.cfilter0(c)
	return c:IsFaceup() and c:IsSetCard(0x9204) 
end
function c1001009.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c1001009.cfilter0,tp,LOCATION_MZONE,0,1,nil)
end
function c1001009.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1001009.filter0(c)
	return c:IsDestructable() 
end
function c1001009.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c1001009.filter0(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1001009.filter0,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c1001009.filter0,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c1001009.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c1001009.tgfilter(c)
	return c:IsAbleToRemove()
end
function c1001009.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1001009.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1001009.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c1001009.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c1001009.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end