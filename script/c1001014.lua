--奇迹小镇-古河早苗
function c1001014.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c1001014.ffilter1,c1001014.ffilter2,true)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(c1001014.splimit)
	c:RegisterEffect(e2)
	--recover conversion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_RECOVER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--reflect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_REFLECT_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c1001014.aclimit)
	e2:SetCondition(c1001014.actcon)
	c:RegisterEffect(e2)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,1001014)
	e2:SetTarget(c1001014.reptg)
	e2:SetValue(c1001014.repval)
	e2:SetOperation(c1001014.repop)
	c:RegisterEffect(e2) 
end
function c1001014.ffilter1(c)
	return c:IsSetCard(0x9204)
end
function c1001014.ffilter2(c)
	return c:IsRace(RACE_FAIRY) 
end
function c1001014.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c1001014.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c1001014.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c1001014.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x9204) and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c1001014.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c1001014.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(1001014,0))
end
function c1001014.repval(e,c)
	return c1001014.repfilter(c,e:GetHandlerPlayer())
end
function c1001014.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
