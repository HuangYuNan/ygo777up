--yaoguaishan
function c100170013.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk,defup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5cd))
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c100170013.value)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--cannot 
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(c100170013.cncon)
	e5:SetValue(c100170013.efilter)
	c:RegisterEffect(e5)
end
function c100170013.cfilter(c)
	return c:IsFaceup() and not c:IsSetCard(0x5cd)
end
function c100170013.cncon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	return not g:IsExists(c100170013.cfilter,1,nil)
end
function c100170013.efilter(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
function c100170013.adfilter(c)
	return c:IsSetCard(0x5cd) and c:IsFaceup()
end
function c100170013.value(e,c)
	return Duel.GetMatchingGroupCount(c100170013.adfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)*200
end