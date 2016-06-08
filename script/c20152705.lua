--叶山隼人
function c20152705.initial_effect(c)
c:SetUniqueOnField(1,0,20152705) 
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
		--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(-300)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152705,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCondition(c20152705.descon)
	e3:SetTarget(c20152705.destg)
	e3:SetOperation(c20152705.desop)
	c:RegisterEffect(e3)
		--atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152705,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetTarget(c20152705.target2)
	e4:SetOperation(c20152705.operation2)
	c:RegisterEffect(e4)
end
function c20152705.cxfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0xc290) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c20152705.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20152705.cxfilter,1,nil,tp)
end
function c20152705.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetChainLimit(c20152705.chlimit)
end
function c20152705.chlimit(e,ep,tp)
	return tp==ep
end
function c20152705.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	Duel.ConfirmCards(tp,g)
end
function c20152705.xfilter2(c)
	return c:IsSetCard(0xc290) and c:IsFaceup()
end
function c20152705.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152705.xfilter2,tp,LOCATION_MZONE,0,1,nil) end
end
function c20152705.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20152705.xfilter2,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
