--水曜
function c233584.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c233584.condition)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233584,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(0x8)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_REPEAT)
	e2:SetCountLimit(1)
	e2:SetCondition(c233584.reccon)
	e2:SetTarget(c233584.rectg)
	e2:SetOperation(c233584.recop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(233584,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(0x8)
	e3:SetCost(c233584.descost)
	e3:SetTarget(c233584.destg)
	e3:SetOperation(c233584.desop)
	c:RegisterEffect(e3)
end
function c233584.filter(c)
	return c:IsFaceup() and c:IsRace(0x2)
end
function c233584.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c233584.filter,tp,0xc,0,1,nil,0x2)
end	
function c233584.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c233584.filter(c)
	return c:IsFaceup() and c:IsRace(0x2)
end
function c233584.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c233584.filter,tp,0x4,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*500)
end
function c233584.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ct=Duel.GetMatchingGroupCount(c233584.filter,tp,0x4,0,nil)
	Duel.Recover(tp,ct*500,REASON_EFFECT)
end
function c233584.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()  end
	Duel.SendtoGrave(e:GetHandler(),0x80)
end
function c233584.desfilter(c,ct)
	return c:IsFaceup() and c:IsDestructable() and c:GetDefense()<=ct
end
function c233584.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,0x10,0,nil,0x2)
    if chk==0 then return Duel.IsExistingMatchingCard(c233584.desfilter,tp,0,0x4,1,nil,ct*300) end
	local g=Duel.GetMatchingGroup(c233584.desfilter,tp,0,0x4,nil,ct*300)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c233584.desop(e,tp,eg,ep,ev,re,r,rp)
    local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,0x10,0,nil,0x2)
    local g=Duel.GetMatchingGroup(c233584.desfilter,tp,0,0x4,nil,ct*300)
	if g:GetCount()>0 then
	Duel.Destroy(g,REASON_EFFECT)
	end
end