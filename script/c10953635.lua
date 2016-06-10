--恩底弥翁的奇迹
function c10953635.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,10953636)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c10953635.reptg)
	e1:SetValue(c10953635.repval)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
end
function c10953635.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x350) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetFlagEffect(10953635)==0
end
function c10953635.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c10953635.repfilter,1,nil,tp) end
	local g=eg:Filter(c10953635.repfilter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(10953635,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(10953635,0))
		tc=g:GetNext()
	end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(g)
	return true
end
function c10953635.repval(e,c)
	local g=e:GetLabelObject()
	return g:IsContains(c)
end
