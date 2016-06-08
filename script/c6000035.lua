--四季的鲜花之主
function c6000035.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c6000035.mfilter,4,2,c6000035.ovfilter,aux.Stringid(6000035,0),2,c6000035.xyzop)
	c:EnableReviveLimit()
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c6000035.aclimit)
	e2:SetCondition(c6000035.actcon)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c6000035.descost)
	e3:SetTarget(c6000035.destg)
	e3:SetOperation(c6000035.desop)
	c:RegisterEffect(e3)
end
function c6000035.mfilter(c)
	return c:IsSetCard(0x300)
end
function c6000035.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x300) and c:IsType(TYPE_XYZ)
end
function c6000035.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,6000035)==0 end
	Duel.RegisterFlagEffect(tp,6000035,RESET_PHASE+PHASE_END,0,1)
end
function c6000035.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c6000035.desfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsDestructable()
end
function c6000035.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6000035.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c6000035.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c6000035.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c6000035.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c6000035.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c6000035.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end