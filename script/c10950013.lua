--叛逆之歌
function c10950013.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10950013,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c10950013.condition)
	e2:SetOperation(c10950013.operation)
	c:RegisterEffect(e2)
	--add COUNTER
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c10950013.ctop)
	c:RegisterEffect(e3)
end
function c10950013.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c10950013.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x3ac,1)
		tc=g:GetNext()
	end
end
function c10950013.ctfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x231) and c:IsType(TYPE_SYNCHRO)
end
function c10950013.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c10950013.ctfilter,1,nil) then
		e:GetHandler():AddCounter(0x3ac,2)
	end
end