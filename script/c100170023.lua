--bailangzhizhu--
function c100170023.initial_effect(c)
	aux.AddSynchroProcedure(c,c100170023.tfilter,aux.NonTuner(Card.IsType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--unspsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	e3:SetCountLimit(1)
	e3:SetCondition(c100170023.discon)
	e3:SetCost(c100170023.cost)
	e3:SetTarget(c100170023.distg)
	e3:SetOperation(c100170023.disop)
	c:RegisterEffect(e3)
	--trap
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c100170023.efilter)
	c:RegisterEffect(e2)
	--reatk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsAttackBelow,c:GetAttack()))
	e4:SetValue(c100170023.adval)
	c:RegisterEffect(e4)
end
function c100170023.adval(e,c)
	return c:GetBaseAttack()
end
function c100170023.filter(c)
	return c:GetSummonPlayer()==tp
end
function c100170023.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(c100170023.filter,1,nil,1-tp)
end
function c100170023.cfilter(c)
	return c:IsSetCard(0x5cd) and c:IsAbleToGraveAsCost()
end
function c100170023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100170023.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.DiscardHand(tp,c100170023.cfilter,1,1,REASON_COST)
end
function c100170023.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c100170023.filter,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c100170023.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100170023.filter,nil,1-tp)
	Duel.NegateSummon(g)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c100170023.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end