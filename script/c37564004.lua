--冰雪元素·布利扎
function c37564004.initial_effect(c)
		--xyz summon
	aux.AddXyzProcedure(c,nil,4,2,nil,nil,5)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564004,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,37564004)
	e1:SetCost(c37564004.cost)
	e1:SetTarget(c37564004.tg)
	e1:SetOperation(c37564004.op)
	c:RegisterEffect(e1)
end
function c37564004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37564004.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_EXTRA) and c:IsDestructable() and (not c:IsType(TYPE_PENDULUM))
end
function c37564004.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c37564004.filter,1,e:GetHandler(),tp) end
	local g=eg:Filter(c37564004.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c37564004.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsPreviousLocation(LOCATION_EXTRA) and c:IsDestructable() and (not c:IsType(TYPE_PENDULUM))
end
function c37564004.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c37564004.filter2,nil,e,tp)
	Duel.Destroy(g,REASON_EFFECT)
end
