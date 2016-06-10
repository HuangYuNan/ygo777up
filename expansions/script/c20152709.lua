--材木座义辉
function c20152709.initial_effect(c)
c:SetUniqueOnField(1,0,20152709)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152709,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c20152709.condition)
	e2:SetTarget(c20152709.target)
	e2:SetOperation(c20152709.operation)
	c:RegisterEffect(e2)
		--atklimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetCondition(c20152709.atkcon)
	c:RegisterEffect(e3)
		--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152709,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLED)
	e4:SetCondition(c20152709.descon)
	e4:SetTarget(c20152709.destg)
	e4:SetOperation(c20152709.desop)
	c:RegisterEffect(e4)
end
function c20152709.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c20152709.filter(c)
	return c:IsFaceup()
end
function c20152709.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152709.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152709.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20152709.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c20152709.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(tc:GetAttack()/2)
		tc:RegisterEffect(e2)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c20152709.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc290) and not c:IsCode(20152709)
end
function c20152709.atkcon(e)
	return not Duel.IsExistingMatchingCard(c20152709.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c20152709.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
function c20152709.desfilter(c)
	return c:IsDestructable()
end
function c20152709.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c20152709.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
