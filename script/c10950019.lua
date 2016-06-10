--木花咲耶
function c10950019.initial_effect(c)	
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10950019.spcon)
	e0:SetOperation(c10950019.spop)
	c:RegisterEffect(e0)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TO_DECK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10950019,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetTarget(c10950019.destg)
	e4:SetOperation(c10950019.desop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(c10950019.efilter)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c10950019.efilter2)
	c:RegisterEffect(e6)
	--attack up
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10955013,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCondition(c10950019.condition)
	e4:SetOperation(c10950019.activate)
	c:RegisterEffect(e4)
end
function c10950019.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsAttribute(ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c10950019.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c10950019.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER)
end
function c10950019.efilter2(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
function c10950019.spfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToGraveAsCost()
end
function c10950019.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x231)
end
function c10950019.syc(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,5,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x13ac,5,REASON_COST)
end
function c10950019.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 
	and Duel.IsExistingMatchingCard(c10950019.spfilter2,tp,LOCATION_MZONE,0,2,nil) then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,5,REASON_COST) and Duel.IsExistingMatchingCard(c10950019.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) 
end
end
function c10950019.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10950019.spfilter,c:GetControler(),LOCATION_MZONE,0,1,1,nil)
	Duel.RemoveCounter(tp,1,0,0x13ac,5,REASON_COST)
	Duel.SendtoGrave(g,REASON_COST) 
end
function c10950019.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil and e:GetHandler():IsRelateToBattle()
end
function c10950019.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsRelateToBattle() then
		local aa=a:GetTextAttack()
		local ad=a:GetTextDefense()
		if a:IsImmuneToEffect(e) then
			aa=a:GetBaseAttack()
			ad=a:GetBaseDefense() end
		if aa<0 then aa=0 end
		if ad<0 then ad=0 end
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCode(EFFECT_SET_ATTACK_FINAL)
		e4:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e4:SetValue(aa)
		a:RegisterEffect(e4,true)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e5:SetRange(LOCATION_MZONE)
		e5:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e5:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e5:SetValue(ad)
		a:RegisterEffect(e5,true)
	end
	if d and d:IsRelateToBattle() then
		local da=d:GetTextAttack()
		local dd=d:GetTextDefense()
		if d:IsImmuneToEffect(e) then 
			da=d:GetBaseAttack()
			dd=d:GetBaseDefense() end
		if da<0 then da=0 end
		if dd<0 then dd=0 end
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e6:SetRange(LOCATION_MZONE)
		e6:SetCode(EFFECT_SET_ATTACK_FINAL)
		e6:SetValue(da)
		e6:SetReset(RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e6,true)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e7:SetRange(LOCATION_MZONE)
		e7:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e7:SetValue(dd)
		e7:SetReset(RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e7,true)
	end
end