--武装女仆 UNKNOWN
function c99999017.initial_effect(c)
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99999003,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHANGE_POS)
    e1:SetCountLimit(1,99999017+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c99999017.condition)
	e1:SetOperation(c99999017.operation)
	c:RegisterEffect(e1)
	--immnue
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_NAGA+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_TO_DECK)
	e3:SetCountLimit(1,99999017+EFFECT_COUNT_CODE_OATH)
	e3:SetCondition(c99999017.imcon)
	e3:SetTarget(c99999017.imtg)
	e3:SetOperation(c99999017.imop)
	c:RegisterEffect(e3)
end
function c99999017.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c99999017.operation(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	    e1:SetCode(EVENT_BE_MATERIAL)
	    e1:SetCondition(c99999017.efcon)
	    e1:SetOperation(c99999017.efop)
	    e:GetHandler():RegisterEffect(e1)
end
function c99999017.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c99999017.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(34143852,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c99999017.atkcon)
	e1:SetTarget(c99999017.atktg)
	e1:SetOperation(c99999017.atkop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2,true)
	end
end
function c99999017.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetHandler():IsSetCard(0x2e5)
end
function c99999017.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return true end  
  Duel.SetChainLimit(c99999017.chlimit)
end
function c99999017.chlimit(e,ep,tp)
	return tp==ep
end
function c99999017.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
    Duel.SetChainLimit(c99999017.chlimit)
end
function c99999017.imcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c99999017.imfilter(c)
	return c:IsFaceup() and  c:IsSetCard(0x2e5)
end 
function c99999017.imtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c99999017.imfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99999017.imfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c99999017.imfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c99999017.imop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	    e1:SetCode(EFFECT_IMMUNE_EFFECT)
	    e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c99999017.efilter)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c99999017.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and e:GetHandlerPlayer()~=te:GetHandlerPlayer()
end