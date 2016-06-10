--100% Orange Juice
function c20320021.initial_effect(c)
	 --xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	--indestructable by effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c20320021.incon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--negate activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20320021,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c20320021.discon)
	e2:SetCost(c20320021.discost)
	e2:SetTarget(c20320021.distg)
	e2:SetOperation(c20320021.disop)
	c:RegisterEffect(e2)
end
function c20320021.incon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c20320021.discon(e,tp,eg,ep,ev,re,r,rp)
	 return re:GetHandler()~=e:GetHandler() and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c20320021.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20320021.disfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAbleToGrave()
end
function c20320021.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320021.disfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c20320021.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20320021.disfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
