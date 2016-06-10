--命运扑克魔术 幻想坎特雷拉
function c66612314.initial_effect(c)
	aux.AddFusionProcFun2(c,c66612314.filter1,c66612314.filter2,false)
	c:SetUniqueOnField(1,0,66612314)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66612314,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c66612314.postg)
	e1:SetOperation(c66612314.posop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c66612314.splimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x660))
	e3:SetValue(c66612314.indval)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c66612314.excon)
	e4:SetTarget(c66612314.extg)
	e4:SetOperation(c66612314.exop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612314,1))
	e5:SetCategory(CATEGORY_TOGRAVE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c66612314.ggcost)
	e5:SetOperation(c66612314.ggop)
	c:RegisterEffect(e5)
end
function c66612314.filter1(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_FUSION)
end
function c66612314.filter2(c)
	return c:IsCode(66612312)
end
function c66612314.pofilter(c)
	return c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c66612314.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612314.pofilter,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c66612314.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c66612314.pofilter,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c66612314.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c66612314.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer() and re:IsActiveType(TYPE_TRAP+TYPE_SPELL)
end
function c66612314.excon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp~=tp and e:GetHandler():GetPreviousControler()==tp and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c66612314.exfilter(c)
	return c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c66612314.extg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c66612314.exfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c66612314.exop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c66612314.exfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Remove(sg,REASON_EFFECT)
end
function c66612314.cfilter(c)
	return c:IsFaceup() and c:IsCode(66612313) and c:IsAbleToRemoveAsCost()
end
function c66612314.ggcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c66612314.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66612314.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Remove(g,REASON_COST)
end
function c66612314.ggop(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
end
