--扑克魔术 蔓越莓
function c66612304.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c66612304.cost)
	e1:SetTarget(c66612304.target)
	e1:SetOperation(c66612304.operation)
	c:RegisterEffect(e1)
	if not c66612304.global_check then
		c66612304.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612304.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612304.clear)
		Duel.RegisterEffect(ge2,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66612304.lvcon)
	e2:SetValue(800)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c66612304.lvcon)
	e3:SetValue(8)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCondition(c66612304.lvcon)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
	--upatk
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612304,0))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c66612304.cost)
	e5:SetCondition(c66612304.atcon)
	e5:SetTarget(c66612304.attarget)
	e5:SetOperation(c66612304.atoperation)
	c:RegisterEffect(e5)
end
function c66612304.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x660) then
			c66612304[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66612304.clear(e,tp,eg,ep,ev,re,r,rp)
	c66612304[0]=true
	c66612304[1]=true
end
function c66612304.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660)
end
function c66612304.lvcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612304.cfilter,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
function c66612304.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable()  and c66612304[tp] end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c66612304.filter(c)
	return c:GetCode()==66612318 and c:IsAbleToHand()
end
function c66612304.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612304.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66612304.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c66612304.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c66612304.atfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660) and c:IsLevelAbove(5)
end
function c66612304.atcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612304.atfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c66612304.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c66612304.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660)
end
function c66612304.attarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66612304.sfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66612304.sfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c66612304.sfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c66612304.atoperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1500)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(66612304,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_PIERCE)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
