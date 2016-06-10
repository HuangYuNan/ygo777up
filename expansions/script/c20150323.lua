--3
function c20150323.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3291),3,2)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150323,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetHintTiming(0,0x1c0)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c20150323.cost)
	e1:SetTarget(c20150323.target)
	e1:SetOperation(c20150323.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20150323,1))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c20150323.reptg)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c20150323.atkval)
	c:RegisterEffect(e3)
end
function c20150323.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(20150323,0)) then
		local c=e:GetHandler()
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		Duel.RaiseSingleEvent(c,20150323,e,0,0,0,0)
		return true
	else return false end
end
function c20150323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150323.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c20150323.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c20150323.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150323.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20150323.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c20150323.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e3)
	end
end
function c20150323.atkval(e,c)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,TYPE_MONSTER)*100
end