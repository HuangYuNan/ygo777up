--花物语·高贵浓郁之风信子
function c10953009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c10953009.condition)
	e2:SetTarget(c10953009.rmtarget)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(10953009)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCondition(c10953009.condition)
	e3:SetTargetRange(0xff,0xff)
	e3:SetTarget(c10953009.checktg)
	c:RegisterEffect(e3)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c10953009.condition)
	e5:SetTarget(c10953009.reptg)
	e5:SetValue(c10953009.repval)
	c:RegisterEffect(e5)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e5:SetLabelObject(g)
	--redirect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCondition(c10953009.recon)
	e6:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e7:SetCountLimit(1)
	e7:SetCondition(c10953009.condition)
	e7:SetValue(c10953009.valcon)
	c:RegisterEffect(e7)
end
function c10953009.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0
end
function c10953009.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and (c:IsSetCard(0x2e4) or c:IsSetCard(0x235)) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetFlagEffect(10953009)==0
end
function c10953009.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c10953009.repfilter,1,nil,tp) end
	local g=eg:Filter(c10953009.repfilter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(10953009,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(10953009,0))
		tc=g:GetNext()
	end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(g)
	return true
end
function c10953009.repval(e,c)
	local g=e:GetLabelObject()
	return g:IsContains(c)
end
function c10953009.rmtarget(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c10953009.checktg(e,c)
	return not c:IsPublic()
end
function c10953009.recon(e)
	return e:GetHandler():IsFaceup()
end
function c10953009.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end