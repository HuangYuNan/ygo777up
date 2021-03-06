--末承者（インへリドゥーム）―カールト
require "expansions/script/c9990000"
function c9991921.initial_effect(c)
	Dazz.InheritorCommonEffect(c,1)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Fuck Monster MZONE
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c9991921.fkcon)
	e1:SetTarget(c9991921.fktg)
	e1:SetOperation(c9991921.fkop)
	c:RegisterEffect(e1)
	--Fuck Monster PZONE
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c9991921.fktg2)
	e2:SetOperation(c9991921.fkop)
	c:RegisterEffect(e2)
end
c9991921.Dazz_name_inheritor=2
function c9991921.fkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c9991921.fkfilter(c,atk)
	return c:IsDestructable() and c:IsFaceup() and c:GetAttack()<atk
end
function c9991921.fkfilter2(c,tp)
	return Dazz.IsInheritor(c) and Duel.IsExistingMatchingCard(c9991921.fkfilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c9991921.fktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=e:GetHandler():GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c9991921.fkfilter,tp,0,LOCATION_MZONE,1,nil,atk) end
	local sg=Duel.GetMatchingGroup(c9991921.fkfilter,tp,0,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,1,0,0)
end
function c9991921.fktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c9991921.fkfilter2,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,c9991921.fkfilter2,tp,LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	local sg=Duel.GetMatchingGroup(c9991921.fkfilter,tp,0,LOCATION_MZONE,nil,tc:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,1,0,0)
end
function c9991921.fkop(e,tp,eg,ep,ev,re,r,rp)
	if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		if not e:GetHandler():IsRelateToEffect(e) then return end
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsRelateToEffect(e) then atk=tc:GetAttack() else return end
	else
		atk=e:GetHandler():GetAttack()
	end
	local sg=Duel.GetMatchingGroup(c9991921.fkfilter,tp,0,LOCATION_MZONE,nil,atk)
	if sg:GetCount()~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local rg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(rg)
		Duel.Destroy(rg,REASON_EFFECT)
	end
end