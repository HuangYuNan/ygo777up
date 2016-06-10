--圆月少女·依绪奈
function c10958774.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),10,3)
	c:EnableReviveLimit()
	--
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c10958774.splimit)
	c:RegisterEffect(e0)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c10958774.atklimit)
	c:RegisterEffect(e1)
	--cannot mset
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_MSET)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e2:SetTargetRange(0,1)
	c:RegisterEffect(e2)
	--devine light
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_DEVINE_LIGHT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
	--cannot turn set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_CANNOT_TURN_SET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e4)
	--must attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_MUST_ATTACK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_EP)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c10958774.becon)
	c:RegisterEffect(e6)
	--to hand
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(10958774,0))
	e7:SetCategory(CATEGORY_REMOVE)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetHintTiming(0,0x1e0)
	e7:SetCost(c10958774.thcost)
	e7:SetTarget(c10958774.rmtg)
	e7:SetOperation(c10958774.rmop)
	c:RegisterEffect(e7)
	--atkdown
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(10958774,1))
	e8:SetCategory(CATEGORY_ATKCHANGE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_FLAG_UNCOPYABLE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetCondition(c10958774.atkcon)
	e8:SetTarget(c10958774.atktg)
	e8:SetOperation(c10958774.atkop)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e9)
	
end
function c10958774.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ and not (se:GetHandler():IsType(TYPE_SPELL) or se:GetHandler():IsType(TYPE_MONSTER) or se:GetHandler():IsType(TYPE_TRAP))
end 
function c10958774.atkfilter(c,e,tp)
	return c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c10958774.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10958774.atkfilter,1,nil,nil,1-tp)
end
function c10958774.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetCard(eg)
end
function c10958774.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c10958774.atkfilter,nil,e,1-tp)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
		local preatk=tc:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-2000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		if preatk~=0 and tc:GetAttack()==0 then dg:AddCard(tc) end
		tc=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
function c10958774.becon(e)
	return Duel.IsExistingMatchingCard(Card.IsAttackable,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c10958774.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	e:GetHandler():RegisterEffect(e1)
end
function c10958774.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end
function c10958774.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c10958774.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_RULE)
	end
end
