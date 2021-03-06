--末承者（インへリドゥーム）―ヴァルコラス
require "expansions/script/c9990000"
function c9991923.initial_effect(c)
	Dazz.InheritorCommonEffect(c,1)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Fuck Attack & Defense
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c9991923.adcon)
	e1:SetTarget(c9991923.adtg)
	e1:SetOperation(c9991923.adop)
	c:RegisterEffect(e1)
	--Ignition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c9991923.adcost)
	e2:SetTarget(c9991923.adtg)
	e2:SetOperation(c9991923.adop)
	c:RegisterEffect(e2)
end
c9991923.Dazz_name_inheritor=2
function c9991923.costfilter(c)
	return c:IsDiscardable() and Dazz.IsInheritor(c)
end
function c9991923.adcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9991923.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c9991923.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c9991923.adcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c9991923.adfilter(c)
	return (c:GetAttack()~=1000 or c:GetDefense()~=1000) and c:IsFaceup()
end
function c9991923.adtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c9991923.adfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9991923.adfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c9991923.adfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c9991923.adop(e,tp,eg,ep,ev,re,r,rp)
	if e:IsHasType(EFFECT_TYPE_IGNITION) then
		if not e:GetHandler():IsRelateToEffect(e) then return end
	end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(1000)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	tc:RegisterEffect(e2)
end