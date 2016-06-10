--200% Mixed Juice
function c20320022.initial_effect(c)
		--xyz summon
	aux.AddXyzProcedure(c,c20320022.mfilter,6,3,c20320022.ovfilter,aux.Stringid(20320022,0))
	c:EnableReviveLimit()
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20320022,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,20320022)
	e3:SetCondition(c20320022.thcon)
	e3:SetTarget(c20320022.thtg)
	e3:SetOperation(c20320022.thop)
	c:RegisterEffect(e3)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c20320022.discon1)
	e2:SetTarget(c20320022.splimit)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c20320022.discon2)
	e1:SetTarget(c20320022.splimit)
	c:RegisterEffect(e1)
	--attack up
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetDescription(aux.Stringid(20320022,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c20320022.cost)
	e4:SetOperation(c20320022.operation)
	c:RegisterEffect(e4)
end
function c20320022.mfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsType(TYPE_PENDULUM)
end
function c20320022.ovfilter(c)
	return c:IsFaceup() and c:IsRankBelow(5) and c:IsRankAbove(4) and c:GetOverlayCount()==0
end
function c20320022.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c20320022.thfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToHand() and c:IsLevelAbove(4) and c:IsType(TYPE_MONSTER)
end
function c20320022.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c20320022.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20320022.thfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20320022.thfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,2,0,0)
end
function c20320022.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c20320022.discon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)<=Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)-5
end
function c20320022.discon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)<=Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)-5
end
function c20320022.splimit(e,c)
	return c:IsLocation(LOCATION_HAND) or c:IsLocation(LOCATION_GRAVE)
end
function c20320022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20320022.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end