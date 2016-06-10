--战场女武神 依蒂
function c11113034.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c11113034.splimit)
	c:RegisterEffect(e1)
	--pendulum
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113034,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,11113034)
	e2:SetCondition(c11113034.condition)
	e2:SetTarget(c11113034.target)
	e2:SetOperation(c11113034.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c11113034.atkcon)
	e4:SetOperation(c11113034.atkop)
	c:RegisterEffect(e4)
	--salvage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(11113034,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_REMOVE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1,111130340)
	e5:SetTarget(c11113034.destg)
	e5:SetOperation(c11113034.desop)
	c:RegisterEffect(e5)
end
function c11113034.splimit(e,c)
	return not (c:IsSetCard(0x15c) or c:IsType(TYPE_SYNCHRO))
end
function c11113034.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:IsSetCard(0x15c) and not c:IsCode(11113034)
end
function c11113034.condition(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return eg:IsExists(c11113034.cfilter,1,nil,tp) and pc and pc:IsSetCard(0x15c)
end	
function c11113034.pfilter(c)
	return c:IsSetCard(0x15c) and not c:IsCode(11113034) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c11113034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113034.pfilter,tp,LOCATION_DECK,0,1,nil)
		and e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c11113034.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.Destroy(c,REASON_EFFECT)~=0 then
	    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113034,2))
		local g=Duel.SelectMatchingCard(tp,c11113034.pfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
function c11113034.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO and not re:GetHandler():IsSetCard(0x15c)
end
function c11113034.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(rc:GetAttack()/2)
	rc:RegisterEffect(e1)
end
function c11113034.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c11113034.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and tc:GetPreviousControler()==tp then
	    Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c11113034.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO and not re:GetHandler():IsSetCard(0x15c)
end
function c11113034.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(rc:GetAttack()/2)
	rc:RegisterEffect(e1)
end