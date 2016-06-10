--白咲学园
function c10950012.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10950012,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c10950012.addct)
	e1:SetOperation(c10950012.addc)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetValue(c10950012.efilter)
	c:RegisterEffect(e3)
	--counter
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10950012,0))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(5,10950012)
	e4:SetCost(c10950012.cost)
	e4:SetTarget(c10950012.addct)
	e4:SetOperation(c10950012.addc2)
	c:RegisterEffect(e4)
end
function c10950012.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c10950012.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x13ac)
end
function c10950012.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x13ac,1)
	end
end
function c10950012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x13ac,2,REASON_COST)
end
function c10950012.addc2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x13ac,2)
	end
end