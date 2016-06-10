--扑克魔术 巧克力
function c66612301.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c66612301.cost)
	e1:SetTarget(c66612301.target)
	e1:SetOperation(c66612301.operation)
	c:RegisterEffect(e1)
	if not c66612301.global_check then
		c66612301.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612301.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612301.clear)
		Duel.RegisterEffect(ge2,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66612301.lvcon)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c66612301.lvcon)
	e3:SetValue(5)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCondition(c66612301.lvcon)
	e4:SetValue(c66612301.valcon)
	c:RegisterEffect(e1)
	--Destroy replace
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66612301,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c66612301.reptg)
	e5:SetValue(c66612301.repval)
	e5:SetOperation(c66612301.repop)
	c:RegisterEffect(e5)
end
function c66612301.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x660) then
			c66612301[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66612301.clear(e,tp,eg,ep,ev,re,r,rp)
	c66612301[0]=true
	c66612301[1]=true
end
function c66612301.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660)
end
function c66612301.lvcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612301.cfilter,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
function c66612301.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() and c66612301[tp] end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c66612301.filter(c)
	return c:GetCode()==66612315 and c:IsAbleToHand()
end
function c66612301.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612301.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66612301.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c66612301.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c66612301.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c66612301.drfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x660) and c:IsLevelAbove(5)
end
function c66612301.drcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c66612302.drfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c66612301.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x660)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c66612301.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c66612301.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(66612301,1))
end
function c66612301.repval(e,c)
	return c66612301.repfilter(c,e:GetHandlerPlayer())
end
function c66612301.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Release(e:GetHandler(),REASON_COST)
end