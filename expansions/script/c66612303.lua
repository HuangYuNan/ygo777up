--扑克魔术 麦芽糖
function c66612303.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c66612303.cost)
	e1:SetTarget(c66612303.target)
	e1:SetOperation(c66612303.operation)
	c:RegisterEffect(e1)
	if not c66612303.global_check then
		c66612303.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612303.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612303.clear)
		Duel.RegisterEffect(ge2,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66612303.lvcon)
	e2:SetValue(700)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c66612303.lvcon)
	e3:SetValue(7)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c66612303.lvcon)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612303,0))
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c66612303.cost)
	e5:SetCondition(c66612303.drawcon)
	e5:SetTarget(c66612303.drtarget)
	e5:SetOperation(c66612303.droperation)
	c:RegisterEffect(e5)
end
function c66612303.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x660) then
			c66612303[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66612303.clear(e,tp,eg,ep,ev,re,r,rp)
	c66612303[0]=true
	c66612303[1]=true
end
function c66612303.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660)
end
function c66612303.lvcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612303.cfilter,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
function c66612303.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable()  and c66612303[tp] end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c66612303.filter(c)
	return c:GetCode()==66612317 and c:IsAbleToHand()
end
function c66612303.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612303.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66612303.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c66612303.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c66612303.drawfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660) and c:IsLevelAbove(5)
end
function c66612303.drawcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612303.drawfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c66612303.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c66612303.drfilter(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c66612303.drtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(c66612303.drfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66612303.droperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c66612303.drfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end