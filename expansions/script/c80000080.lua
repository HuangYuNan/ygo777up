--口袋妖怪 Mega烈咬陆鲨
function c80000080.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,10000000)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)  
	--attack all
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2) 
--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(80000080,0))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetCondition(c80000080.damcon)
	e5:SetTarget(c80000080.damtg)
	e5:SetOperation(c80000080.damop)
	c:RegisterEffect(e5) 
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetCondition(c80000080.con)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c80000080.aclimit)
	c:RegisterEffect(e3)
end
function c80000080.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c80000080.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(bc)
	local dam=bc:GetAttack()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c80000080.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local dam=tc:GetAttack()
		if dam<0 then dam=0 end
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
function c80000080.con(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_BATTLE or ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end
function c80000080.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_TRAP+TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end


