--バイオテック・ドラゴン
function c9990203.initial_effect(c)
	--Fusion
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,function(c) return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO) end,function(c) return c:IsRace(RACE_MACHINE) end,1,4,true)
	--Damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c9990203.dmcon)
	e1:SetTarget(c9990203.dmtg)
	e1:SetOperation(c9990203.dmop)
	c:RegisterEffect(e1)
	--Attack Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCondition(c9990203.aucon)
	e2:SetOperation(c9990203.auop)
	c:RegisterEffect(e2)
end
c9990203.miracle_synchro_fusion=true
function c9990203.dmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c9990203.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local val=e:GetHandler():GetMaterial():FilterCount(Card.IsRace,nil,RACE_MACHINE)*1000
	if val==0 then return end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end
function c9990203.dmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local val=c:GetMaterial():FilterCount(Card.IsRace,nil,RACE_MACHINE)*1000
	if c:IsFacedown() or not c:IsRelateToEffect(e) or val==0 then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,val,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(function(e,re,val,r,rp,rc)
		if bit.band(r,REASON_EFFECT)~=0 then return 0 else return val end
	end)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c9990203.aucon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d~=e:GetHandler() and d:GetAttack()+d:GetDefense()~=0 and d:IsFaceup()
end
function c9990203.auop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler() local d=Duel.GetAttackTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local val=(d:GetAttack()-math.ceil(d:GetDefense()/2))
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end