--四糸乃-天使显现
function c20150328.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),4,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150328,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c20150328.cost)
	e1:SetTarget(c20150328.target)
	e1:SetOperation(c20150328.operation)
	c:RegisterEffect(e1)
	--activate limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20150328.accon)
	e3:SetOperation(c20150328.aclimit1)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_CHAIN_NEGATED)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c20150328.accon)
	e4:SetOperation(c20150328.aclimit2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,1)
	e5:SetCondition(c20150328.econ)
	e5:SetValue(c20150328.elimit)
	c:RegisterEffect(e5)
end
function c20150328.accon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20150303)
end
function c20150328.filter(c,e,tp)
	return c:IsFaceup() and c:IsControler(1-tp) and c:IsLevelBelow(4) and (not e or c:IsRelateToEffect(e))
end
function c20150328.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150328.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20150328.filter,1,nil,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c20150328.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c20150328.filter,nil,e,tp)
	Duel.Destroy(g,REASON_EFFECT)
end
function c20150328.aclimit1(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not re:IsHasType(EFFECT_TYPE_ACTIONS) then return end
	e:GetHandler():RegisterFlagEffect(20150328,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
end
function c20150328.aclimit2(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not re:IsHasType(EFFECT_TYPE_ACTIONS) then return end
	e:GetHandler():ResetFlagEffect(20150328)
end
function c20150328.econ(e)
	return e:GetHandler():GetFlagEffect(20150328)~=0 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20150303)
end
function c20150328.elimit(e,te,tp)
	return te:IsHasType(EFFECT_TYPE_ACTIONS)
end
