--冰洁之术士
function c23456750.initial_effect(c)
	--添加灵摆属性
	aux.EnablePendulumAttribute(c)
	--检索仪式
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23456750,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,23456750)
	e1:SetCost(c23456750.thcost)
	e1:SetTarget(c23456750.target)
	e1:SetOperation(c23456750.operation)
	c:RegisterEffect(e1)
	--魔陷无效
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(23456750,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,23456750)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,23456750)
	e2:SetCondition(c23456750.descondition)
	e2:SetTarget(c23456750.destarget)
	e2:SetOperation(c23456750.desactivate)
	c:RegisterEffect(e2)
	--仪式召唤
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23456750,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,234567501)
	e3:SetCost(c23456750.drnocost)
	e3:SetTarget(c23456750.drnotarget)
	e3:SetOperation(c23456750.drnooperation)
	c:RegisterEffect(e3)
	--抽卡效果
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetDescription(aux.Stringid(23456750,3))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_RELEASE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,234567501)
	e4:SetTarget(c23456750.drtarget)
	e4:SetOperation(c23456750.dractivate)
	c:RegisterEffect(e4)
	--解放代替
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_RITUAL_LEVEL)
	e5:SetValue(c23456750.rlevel)
	c:RegisterEffect(e5)
end
----解放代替--------------------------------------------------------
function c23456750.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsSetCard(0x531) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
----抽卡效果----------------------------------------------------------
function c23456750.drtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c23456750.dractivate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
----仪式召唤-----------------------------------------------------------
function c23456750.drnocfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and not c:IsCode(23456750)
end
function c23456750.drnocost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.CheckReleaseGroup(tp,c23456750.drnocfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c23456750.drnocfilter,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c23456750.drnotarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c23456750.drnooperation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end


-----检索仪式-------------------------------------------------------------
function c23456750.cfilter(c)
	return c:IsDiscardable()
end
function c23456750.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456750.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c23456750.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c23456750.filter(c)
	return c:IsSetCard(0x531) and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_SPELL)) and c:IsAbleToHand()
end
function c23456750.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456750.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c23456750.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c23456750.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
-----魔陷无效-------------------------------------------------------------
function c23456750.confilter(c)
	return c:IsFaceup() and not c:IsCode(23456750) and c:IsSetCard(0x531)
end
function c23456750.descondition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c23456750.confilter,tp,LOCATION_ONFIELD,0,1,nil) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c23456750.destarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c23456750.desactivate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
-----------------------------------------------------------------------