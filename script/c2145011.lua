--九尾狐 银
function c2145011.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c2145011.spcon)
	c:RegisterEffect(e1)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c2145011.reptg)
	e1:SetValue(c2145011.repval)
	e1:SetOperation(c2145011.repop)
	c:RegisterEffect(e1)
end
function c2145011.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x216) and c:GetCode()~=2145011
end
function c2145011.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c2145011.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c2145011.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x216)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c2145011.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c2145011.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(2145013,0))
end
function c2145011.repval(e,c)
	return c2145011.repfilter(c,e:GetHandlerPlayer())
end
function c2145011.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end