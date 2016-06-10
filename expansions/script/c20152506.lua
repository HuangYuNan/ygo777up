--菲尔
function c20152506.initial_effect(c)
	c:SetUniqueOnField(1,0,20152506)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152506,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c20152506.thtg)
	e1:SetOperation(c20152506.thop)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152506,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c20152506.cost)
	e2:SetOperation(c20152506.operation)
	c:RegisterEffect(e2)
end
function c20152506.tgfilter(c)
	return c:IsCode(20152505) and c:IsAbleToHand()
end
function c20152506.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:GetControler()==tp and c20152506.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152506.tgfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c20152506.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20152506.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c20152506.cfilter(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c20152506.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c20152506.cfilter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return g:GetClassCount(Card.GetCode)>0 end
	local tg=Group.CreateGroup()
	for i=1,1 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
		tg:Merge(sg)
	end
	Duel.SendtoGrave(tg,REASON_COST)
end
function c20152506.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152506.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20152506.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c20152506.efilter)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c20152506.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
