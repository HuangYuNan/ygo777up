--卒業おめでとう
function c10950017.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c10950017.condition)
	e1:SetCost(c10950017.cost)
	c:RegisterEffect(e1)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(c10950017.efilter)
	c:RegisterEffect(e3)
	--lv change
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetCountLimit(1)
	e7:SetHintTiming(0,0x1e0)
    e7:SetCondition(c10950017.condition2)
	e7:SetOperation(c10950017.activate)
	c:RegisterEffect(e7)
	if not c10950017.global_check then
		c10950017.global_check=true
		c10950017[0]=false
		c10950017[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c10950017.chop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c10950017.cfilter(c)
	return c:IsFaceup() and c:IsCode(10950012)
end
function c10950017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,29,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x13ac,29,REASON_COST)
end
function c10950017.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10950017.cfilter,0,LOCATION_ONFIELD,0,1,nil) 
end
function c10950017.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c10950017.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SelectOption(tp,aux.Stringid(10950017,0))
	Duel.SelectOption(tp,aux.Stringid(10950017,1))
	Duel.SelectOption(tp,aux.Stringid(10950017,2))
	Duel.SelectOption(tp,aux.Stringid(10950017,3))
	Duel.SelectOption(tp,aux.Stringid(10950017,4))
	Duel.SelectOption(tp,aux.Stringid(10950017,5))
	Duel.SetLP(1-tp,0)
end
function c10950017.condition2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c10950017.cfilter,0,LOCATION_ONFIELD,0,1,nil) and Duel.GetFlagEffect(tp,10950017)==0 and c10950017[e:GetHandlerPlayer()]
end
function c10950017.chop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rc:IsCode(10950017) then
		c10950017[rp]=true
	end
end