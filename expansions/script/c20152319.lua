--梅露露演唱会
function c20152319.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,20152319)
	e1:SetCondition(c20152319.condition3)
	e1:SetCost(c20152319.cost)
	e1:SetTarget(c20152319.target)
	e1:SetOperation(c20152319.activate)
	c:RegisterEffect(e1)
end
	function c20152319.cfilter7(c)
	return c:IsFaceup() and (c:IsCode(20152303)
 or c:IsCode(20152316))
end
function c20152319.condition3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20152319.cfilter7,tp,LOCATION_MZONE,0,1,nil)
end
function c20152319.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c20152319.filter(c)
	return c:IsSetCard(0x5290) and c:IsAbleToHand() and c:IsType(TYPE_PENDULUM)
end
function c20152319.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c20152319.filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20152319.filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,2,0,0)
end
function c20152319.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
