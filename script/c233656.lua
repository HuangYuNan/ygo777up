--祈愿花
function c233656.initial_effect(c)
    c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
    --Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233656,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c233656.negcon)
	e1:SetCost(c233656.negcost)
	e1:SetTarget(c233656.negtg)
	e1:SetOperation(c233656.negop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(233656,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c233656.sumtg)
	e2:SetOperation(c233656.sumop)
	c:RegisterEffect(e2)
end
function c233656.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) 
	and re:IsHasType(EFFECT_TYPE_ACTIVATE) and not (re:GetHandler():GetType()==0x10002 or re:GetHandler():GetType()==0x100004) 
	--and(rc:GetType()==TYPE_SPELL or rc:GetType()==TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
	and Duel.IsChainNegatable(ev)
end
function c233656.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
	local ct=2
	if re:GetHandler():IsType(0x2) and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,0x2,0,1,nil) then ct=ct-1 end
	e:SetLabel(ct)
	return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,0x2,0,2,nil) end
	local ct=e:GetLabel()
	Duel.DiscardHand(tp,Card.IsDiscardable,ct,ct,0x4080)
end
function c233656.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
	local ft1=Duel.GetFieldGroupCount(tp,0xc,0) 
	local ft2=Duel.GetFieldGroupCount(tp,0,0xc) 
	if ft1>ft2 then return true end
	return Duel.GetTurnPlayer()==tp end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c233656.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re)then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c233656.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ft=Duel.GetLocationCount(1-tp,0x4)
	if chk==0 then return ft>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c233656.sumop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(1-tp,0x4)
	if not Duel.IsPlayerCanSpecialSummonMonster(1-tp,15341822,0,0x4011,0,0,1,0x400,0x8) then return end
	for i=1,ft do
	if ft<=0 then return end
		local token=Duel.CreateToken(tp,15341822)
		Duel.SpecialSummon(token,0,1-tp,1-tp,false,false,0x1) 
	end	
end