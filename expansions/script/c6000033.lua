--藏书屋·东风谷早苗
function c6000033.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c6000033.splimit)
	c:RegisterEffect(e1)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c6000033.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c6000033.limit)
	c:RegisterEffect(e7)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_PZONE)
	e2:SetOperation(c6000033.recop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c6000033.atkcon)
	e4:SetOperation(c6000033.atkop)
	c:RegisterEffect(e4)
end
function c6000033.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0x7a77) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c6000033.limit(e,c)
	if not c then return false end
	return not (c:IsSetCard(0x300) or c:IsSetCard(0xa78))
end
function c6000033.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,200,REASON_EFFECT)
end
function c6000033.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO or REASON_XYZ 
end
function c6000033.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6000033,0))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1)
end