--漆黑的烈焰使
function c20152213.initial_effect(c)
c:SetUniqueOnField(1,0,20152213)
	--synchro summon
		aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x3290),1)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c20152213.aclimit)
	e1:SetCondition(c20152213.actcon)
	c:RegisterEffect(e1)
		--Negate summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(20152213,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SUMMON)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
e2:SetCost(c20152211.cost)
	e2:SetCondition(c20152213.discon)
	e2:SetTarget(c20152213.distg)
	e2:SetOperation(c20152213.disop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(20152213,1))
	e3:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetDescription(aux.Stringid(20152213,2))
	e4:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e4)
end
function c20152213.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c20152213.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c20152213.filter(c)
	return c:IsSetCard(0x3290) and c:IsDiscardable()
end
function c20152213.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152213.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20152213.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20152213.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c20152213.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c20152213.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end