--桐谷直叶
function c20152603.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152603,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20152603)
	e1:SetCost(c20152603.thcost)
	e1:SetTarget(c20152603.thtg)
	e1:SetOperation(c20152603.thop)
	c:RegisterEffect(e1)
		--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(20152603,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,20152603)
	e2:SetTarget(c20152603.thtg2)
	e2:SetOperation(c20152603.thop2)
	c:RegisterEffect(e2)
end
function c20152603.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c20152603.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c20152603.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c20152603.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==1 then
		local g=Duel.GetOperatedGroup()
		if g:GetFirst():IsSetCard(0xa290) then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,c20152603.thfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if dg:GetCount()>0 then
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	end
		end
	end
end
function c20152603.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa290) and not c:IsCode(20152603)
end
function c20152603.thfilter2(c)
	return c:IsSetCard(0xa290) and not c:IsCode(20152603) and c:IsType(TYPE_MONSTER)
end
function c20152603.thtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c20152603.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152603.tgfilter,tp,LOCATION_REMOVED,0,2,nil)
		and Duel.IsExistingMatchingCard(c20152603.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c20152603.tgfilter,tp,LOCATION_REMOVED,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20152603.thop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,c20152603.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
		if sg:GetCount()>0 then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
