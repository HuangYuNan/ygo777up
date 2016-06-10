--寂静的元素·Miracle·Melodious
function c10950777.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),4,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c10950777.efilter)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c10950777.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10950777.alpcon)
	e3:SetOperation(c10950777.alpop)
	c:RegisterEffect(e3)
	--activate cost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_ACTIVATE_COST)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	e4:SetCondition(c10950777.paylcon)
	e4:SetCost(c10950777.costchk)
	e4:SetOperation(c10950777.costop)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTORY)
	e5:SetDescription(aux.Stringid(10950777,0))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c10950777.cost)
	e5:SetTarget(c10950777.target)
	e5:SetOperation(c10950777.operation)
	c:RegisterEffect(e5)
end
function c10950777.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(10950777,RESET_EVENT+0x1fc0000+RESET_CHAIN,0,1)
end
function c10950777.alpcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler() 
	return ep~=tp and c:GetFlagEffect(10950777)~=0 and not re:GetHandler():IsLocation(LOCATION_ONFIELD)
end
function c10950777.alpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,10950777)
	Duel.Recover(tp,1000,REASON_EFFECT)
end
function c10950777.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and not re:GetHandler():IsLocation(LOCATION_ONFIELD)
end
function c10950777.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c10950777.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTORY,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c10950777.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g1=Duel.GetDecktopGroup(tp,1)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	g1:Merge(g2)
	Duel.DisableShuffleCheck()
	Duel.Destroy(g1,REASON_EFFECT)
end
function c10950777.cfilter(c)
	return c:IsCode(10950777)
end
function c10950777.paylcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10950777.cfilter,0,LOCATION_GRAVE,0,2,nil)
end
function c10950777.costchk(e,te_or_c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c10950777.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end