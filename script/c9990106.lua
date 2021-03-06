--薬剤師の学徒、リオン
function c9990106.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Negate Attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9990106,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c9990106.tg1)
	e1:SetOperation(c9990106.op1)
	c:RegisterEffect(e1)
	--Negate Effect
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(9990106,1))
	e2:SetCode(EVENT_CHAINING)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c9990106.con1)
	c:RegisterEffect(e2)
	--Turn End
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9990106,2))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetHintTiming(0,0xffffffff)
	e3:SetCondition(c9990106.con2)
	e3:SetCost(c9990106.cost2)
	e3:SetOperation(c9990106.op2)
	c:RegisterEffect(e3)
	--Pendulum Effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(function(e,c)
		return bit.band(c:GetSummonType(),SUMMON_TYPE_PENDULUM)~=0 and c:GetSummonLocation()==LOCATION_EXTRA
	end)
	e4:SetValue(function(e,te)
		return te:GetHandler():IsType(TYPE_TRAP)
	end)
	c:RegisterEffect(e4)
end
function c9990106.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c9990106.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c) and Duel.IsChainNegatable(ev)
end
function c9990106.op1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		if e:GetCode()==EVENT_BE_BATTLE_TARGET then
			Duel.NegateAttack()
		else
			if Duel.IsChainNegatable(ev) then Duel.NegateActivation(ev) end
		end
	else
		if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(2500)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
	Duel.RegisterFlagEffect(0,9990106,RESET_PHASE+PHASE_END,0,1)
end
function c9990106.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(0,9990106)~=0 and Duel.GetCurrentPhase()~=PHASE_END
end
function c9990106.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c9990106.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c9990106.cfilter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return g:GetClassCount(Card.GetCode)>2 end
	local mg=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=g:Select(tp,1,1,nil)
		mg:Merge(tg)
		g:Remove(Card.IsCode,nil,tg:GetFirst():GetCode())
	end
	Duel.SendtoGrave(mg,REASON_COST)
end
function c9990106.op2(e,tp,eg,ep,ev,re,r,rp)
	local fp=Duel.GetTurnPlayer()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,fp)
	Duel.SkipPhase(fp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(fp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(fp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(fp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(fp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
end