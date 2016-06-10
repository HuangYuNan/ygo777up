--藏书屋·魂魄妖梦
function c6000032.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c6000032.splimit)
	c:RegisterEffect(e2)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c6000032.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c6000032.limit)
	c:RegisterEffect(e7)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6000032,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCountLimit(1,6000032)
	e1:SetCondition(c6000032.sumcon)
	e1:SetTarget(c6000032.sumtg)
	e1:SetOperation(c6000032.sumop)
	c:RegisterEffect(e1)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6000032,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCountLimit(1,6132)
	e3:SetCondition(c6000032.atcon)
	e3:SetOperation(c6000032.atop)
	c:RegisterEffect(e3)
	--attack up
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6000032,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCountLimit(1,6232)
	e4:SetCondition(c6000032.condition)
	e4:SetOperation(c6000032.operation)
	c:RegisterEffect(e4)
end
function c6000032.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle()
end
function c6000032.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c6000032.atcon(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) 
		and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE) 
end
function c6000032.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c6000032.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and bit.band(r,REASON_BATTLE)~=0
end
function c6000032.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c6000032.sumop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c6000032.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0x300) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c6000032.limit(e,c)
	if not c then return false end
	return not (c:IsSetCard(0x300) or c:IsSetCard(0xa78))
end