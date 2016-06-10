--冰洁之先导
function c23456757.initial_effect(c)
	--添加灵摆属性
	aux.EnablePendulumAttribute(c)
	--检索仪式
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23456757,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,23456757)
	e1:SetCost(c23456757.thcost)
	e1:SetTarget(c23456757.target)
	e1:SetOperation(c23456757.operation)
	c:RegisterEffect(e1)
	--魔陷无效
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(23456757,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,23456757)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c23456757.descondition)
	e2:SetTarget(c23456757.destarget)
	e2:SetOperation(c23456757.desactivate)
	c:RegisterEffect(e2)
	--Destroy monster
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,234567571)
	e3:SetCost(c23456757.descost2)
	e3:SetTarget(c23456757.destg2)
	e3:SetOperation(c23456757.desop2)
	c:RegisterEffect(e3)
	--atk/def up
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23456757,2))
	e4:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_RELEASE)
	e4:SetCountLimit(1,234567571)
	e4:SetTarget(c23456757.adtg)
	e4:SetOperation(c23456757.adop)
	c:RegisterEffect(e4)
	--解放代替
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_RITUAL_LEVEL)
	e5:SetValue(c23456757.rlevel)
	c:RegisterEffect(e5)
end
----解放代替--------------------------------------------------------
function c23456757.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsSetCard(0x531) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
-----------------------------------------------------------------
function c23456757.cfilter(c)
	return c:IsDiscardable()
end
function c23456757.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456757.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c23456757.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c23456757.filter(c)
	return c:IsSetCard(0x531) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c23456757.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c23456757.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
		and Duel.IsExistingTarget(c23456757.filter,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c23456757.filter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c23456757.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=3 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==3 then
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
-----------------------------------------------------------------------
function c23456757.confilter(c)
	return c:IsFaceup() and not c:IsCode(23456757) and c:IsSetCard(0x531)
end
function c23456757.descondition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c23456757.confilter,tp,LOCATION_ONFIELD,0,1,nil) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsActiveType(TYPE_MONSTER) 
end
function c23456757.destarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c23456757.desactivate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
----------------------------------------------------------------------
function c23456757.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c23456757.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c23456757.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
----------------------------------------------------------------------
function c23456757.adfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and bit.band(c:GetType(),0x81)==0x81
end
function c23456757.adtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456757.adfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c23456757.adop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23456757.adfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end