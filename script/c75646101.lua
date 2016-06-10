--凑
function c75646101.initial_effect(c)
	 c:EnableReviveLimit()
	 --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c75646101.spcon)
	e1:SetOperation(c75646101.spop)
	c:RegisterEffect(e1)
	--cannot special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	--disable attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75646101,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1,75646101+EFFECT_COUNT_CODE_DUEL)
	e3:SetCondition(c75646101.scon)
	e3:SetCost(c75646101.damcost)
	e3:SetOperation(c75646101.atkop)
	c:RegisterEffect(e3)
end
function c75646101.spfilter(c)
	return c:IsSetCard(0x2c0) and c:IsAbleToRemoveAsCost()
end
function c75646101.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75646101.spfilter,tp,LOCATION_GRAVE,0,2,nil)
end
function c75646101.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75646101.spfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c75646101.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c75646101.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c75646101.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c0) and c:IsType(TYPE_MONSTER) and not c:IsCode(75646101)
end
function c75646101.scon(e)
	return Duel.IsExistingMatchingCard(c75646101.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end