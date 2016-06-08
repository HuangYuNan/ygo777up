--上海人形
function c1006.initial_effect(c)
	c:EnableUnsummonable()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1006,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1006)
	e1:SetTarget(c1006.thtg)
	e1:SetOperation(c1006.thop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x989))
	c:RegisterEffect(e2)
	--spsummon limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c1006.splimit)
	c:RegisterEffect(e3)
end
function c1006.filter(c,seq)
	return c:GetSequence()==seq and c:IsAbleToHand()
end
function c1006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c1006.filter,tp,0,LOCATION_ONFIELD,1,nil,4-e:GetHandler():GetSequence()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RHAND)
	local g=Duel.GetMatchingGroup(c1006.filter,tp,0,LOCATION_ONFIELD,nil,4-e:GetHandler():GetSequence())
	Duel.SetOperationInfo(0,CATEGORY_RHAND,g,g:GetCount(),0,0)
end
function c1006.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1006.filter,tp,0,LOCATION_ONFIELD,nil,4-e:GetHandler():GetSequence())
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
function c1006.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x989)
end