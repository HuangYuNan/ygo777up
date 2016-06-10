--仆らは今のなかで
function c20152825.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c20152825.val)
	c:RegisterEffect(e2)
		--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c20152825.reptg)
	e3:SetValue(c20152825.repval)
	e3:SetOperation(c20152825.repop)
	c:RegisterEffect(e3)
end
function c20152825.filter5(c)
	return c:IsSetCard(0x9290) and c:IsFaceup()
end
function c20152825.val(e,c)
	return Duel.GetMatchingGroupCount(c20152825.filter5,e:GetOwnerPlayer(),LOCATION_ONFIELD,0,nil)*-100
end
function c20152825.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD)
		and c:IsSetCard(0x9290) and not c:IsReason(REASON_REPLACE)
end
function c20152825.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20152825.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(20152825,0))
end
function c20152825.repval(e,c)
	return c20152825.repfilter(c,e:GetHandlerPlayer())
end
function c20152825.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
