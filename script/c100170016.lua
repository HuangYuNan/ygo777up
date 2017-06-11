--hongfengzhidao
function c100170016.initial_effect(c)
	c:EnableCounterPermit(0x3036)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add COUNTER
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c100170016.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c100170016.cncon)
	e4:SetTarget(c100170016.cntg)
	e4:SetValue(c100170016.indval)
	c:RegisterEffect(e4)
end
function c100170016.cncon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCounter(0x3036)
	if g>=10 then return true end
end
function c100170016.cntg(e,c)
	return c:IsSetCard(0x5cd)
end
function c100170016.ctfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5cd)
end
function c100170016.indval(e,re)
	return e:GetHandlerPlayer()~=re:GetOwnerPlayer()
end
function c100170016.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c100170016.ctfilter,1,nil) then
		e:GetHandler():AddCounter(0x3036,1)
	end
end