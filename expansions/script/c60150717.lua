--学园偶像 学徒型罗艾娜
function c60150717.initial_effect(c)
	c:SetUniqueOnField(1,0,60150717)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e11)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c60150717.splimit)
	e2:SetCondition(c60150717.splimcon)
	c:RegisterEffect(e2)
	--pendulum
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCountLimit(1,6010716)
	e4:SetCost(c60150717.cost)
	e4:SetCondition(c60150717.spcon)
	e4:SetTarget(c60150717.pentg)
	e4:SetOperation(c60150717.penop)
	c:RegisterEffect(e4)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c60150717.target)
	e1:SetOperation(c60150717.activate)
	c:RegisterEffect(e1)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60150717,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c60150717.condition)
	e3:SetTarget(c60150717.target2)
	e3:SetOperation(c60150717.operation2)
	c:RegisterEffect(e3)
	--poh 
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(60150717,2))
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c60150717.condition2)
	e5:SetTarget(c60150717.target3)
	e5:SetOperation(c60150717.thop)
	c:RegisterEffect(e5)
	--免疫破坏
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(1)
	e6:SetCondition(c60150717.condition)
	c:RegisterEffect(e6)
	--control
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e8:SetCondition(c60150717.condition)
	c:RegisterEffect(e8)
end
function c60150717.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb22) or (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c60150717.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c60150717.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c60150717.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7))
end
function c60150717.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lsc=Duel.CheckLocation(tp,LOCATION_SZONE,6)
	local rsc=Duel.CheckLocation(tp,LOCATION_SZONE,7)
	if chk==0 then return lsc or rsc end
end
function c60150717.penop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
function c60150717.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and not c:IsDisabled()
end
function c60150717.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c60150717.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150717.filter2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60150717.filter2,tp,0,LOCATION_MZONE,1,1,nil)
end
function c60150717.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() and tc:IsControler(1-tp) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
	end
end
function c60150717.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,60150712)
end
function c60150717.filter3(c,atk)
	return c:IsFaceup() and c:GetDefense()<atk and c:IsDestructable()
end
function c60150717.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60150717.filter3(chkc,e:GetHandler():GetAttack()) end
	if chk==0 then return Duel.IsExistingTarget(c60150717.filter3,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c60150717.filter3,tp,0,LOCATION_MZONE,1,1,nil,e:GetHandler():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c60150717.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)
		and tc:GetDefense()<c:GetAttack() and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c60150717.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,60150712)
end
function c60150717.filter4(c)
	return c:IsFaceup()
end
function c60150717.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60150717.filter4(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150717.filter4,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c60150717.filter4,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c60150717.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(1250)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(EFFECT_AUTO_BE_ATTACKED)
		e3:SetRange(LOCATION_MZONE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end