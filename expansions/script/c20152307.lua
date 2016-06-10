--槙岛沙织
function c20152307.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152307,0))
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCountLimit(1,20152307)
	e2:SetCondition(c20152307.con)
	e2:SetOperation(c20152307.op)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152307,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROY)
	e3:SetCountLimit(1)
	e3:SetCondition(c20152307.condition)
	e3:SetTarget(c20152307.target)
	e3:SetOperation(c20152307.operation)
	c:RegisterEffect(e3)
	--splimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(1,0)
	e4:SetCondition(function(e) return not e:GetHandler():IsHasEffect(EFFECT_FORBIDDEN) end)
	e4:SetTarget(c20152307.splimit)
	c:RegisterEffect(e4)
	--scale
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetCode(EFFECT_CHANGE_LSCALE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetRange(LOCATION_PZONE)
	--e4:SetCondition(c20152307.sccon)
	--e4:SetValue(4)
	--c:RegisterEffect(e4)
	--local e5=e4:Clone()
	--e5:SetCode(EFFECT_CHANGE_RSCALE)
	--c:RegisterEffect(e5)
end
function c20152307.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x5290)
end
--function c20152307.sccon(e)
	--local seq=e:GetHandler():GetSequence()
	--local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	--return not tc or not tc:IsSetCard(0x5290)
--end
function c20152307.con(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return Duel.GetTurnPlayer()~=tp and Duel.GetBattleDamage(tp)>0 and tc and tc:IsSetCard(0x5290)
end
function c20152307.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c20152307.damop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c20152307.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c20152307.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetPreviousControler()==tp
end
function c20152307.filter(c,e,tp)
	return c:IsSetCard(0x5290) and not c:IsCode(20152307) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20152307.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20152307.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c20152307.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152307.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end