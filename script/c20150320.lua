--随意领域
function c20150320.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c20150320.desrepcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c20150320.indtg)
	e3:SetCountLimit(1)
	e3:SetValue(c20150320.valcon)
	c:RegisterEffect(e3)
end
function c20150320.indtg(e,c)
	return c:IsSetCard(0x5291) or c:IsSetCard(0x9291)
end
function c20150320.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c20150320.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x5291) or c:IsSetCard(0x9291)
end
function c20150320.desrepcon(e)
	return Duel.IsExistingMatchingCard(c20150320.filter1,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end