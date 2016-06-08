--演奏者 竖琴
function c3201011.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x341),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--immue
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x341))
	e1:SetValue(c3201011.efilter)
	c:RegisterEffect(e1)
	--summon synchro success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3201011,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,3201011)
	e2:SetCondition(c3201011.spcon)
	e2:SetTarget(c3201011.sptg)
	e2:SetOperation(c3201011.spop)
	c:RegisterEffect(e2)
end
function c3201011.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c3201011.spcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c3201011.filter(c,e,tp)
	return c:IsSetCard(0x341) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c3201011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c3201011.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c3201011.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3201011.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
