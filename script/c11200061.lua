--碎月
function c11200061.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,11261)
	e2:SetCondition(c11200061.condition)
	e2:SetTarget(c11200061.target)
	e2:SetOperation(c11200061.activate)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(c11200061.tar)
	e3:SetValue(1000)
	c:RegisterEffect(e3)
end
function c11200061.gfilter(c,tp)
	return c:IsFaceup() and c:IsCode(11200058) and c:IsType(TYPE_MONSTER) and c:IsControler(tp)
end
function c11200061.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11200061.gfilter,1,nil,tp)
end
function c11200061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c11200061.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c11200061.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x250) and c:IsType(TYPE_MONSTER)
end
function c11200061.tar(e,c)
	local g=Duel.GetMatchingGroup(c11200061.atkfilter,tp,LOCATION_MZONE,0,nil):GetMaxGroup(Card.GetAttack)
	return g:IsContains(c)
end