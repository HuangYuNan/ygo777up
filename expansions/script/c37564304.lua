--丛云伴月风拂花
function c37564304.initial_effect(c)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(Card.IsType,TYPE_SYNCHRO),2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.synlimit)
	c:RegisterEffect(e1)
	c:SetUniqueOnField(1,1,37564304)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c37564304.discost)
	e3:SetCondition(c37564304.discon)
	e3:SetTarget(c37564304.distg)
	e3:SetOperation(c37564304.disop)
	c:RegisterEffect(e3)
end
function c37564304.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and e:GetHandler():GetOriginalCode()==37564304 and ep~=tp
end
function c37564304.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ch=Duel.GetCurrentChain()*1000
	local cd=ch+37500304
	local ncd=cd+1000
	if chk==0 then return Duel.GetFlagEffect(tp,ncd)==0 end
	Duel.RegisterFlagEffect(tp,cd,RESET_PHASE+PHASE_END,0,1)
end
function c37564304.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37564304.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end