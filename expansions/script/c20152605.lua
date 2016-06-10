--筱崎里香
function c20152605.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152605,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,20152605)
	e1:SetCost(c20152605.thcost)
	e1:SetTarget(c20152605.thtg)
	e1:SetOperation(c20152605.thop)
	c:RegisterEffect(e1)
		--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetDescription(aux.Stringid(20152605,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,20152605)
	e2:SetTarget(c20152605.target2)
	e2:SetOperation(c20152605.activate2)
	c:RegisterEffect(e2)
end
function c20152605.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c20152605.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c20152605.thfilter(c)
	return c:IsFaceup() and (c:IsLocation(LOCATION_SZONE) or c:IsType(TYPE_EFFECT)) and not c:IsDisabled()
end
function c20152605.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==1 then
		local g=Duel.GetOperatedGroup()
		if g:GetFirst():IsSetCard(0xa290) then
	local c=e:GetHandler()
	local tg=Duel.GetMatchingGroup(c20152605.thfilter,tp,0,LOCATION_ONFIELD,c)
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=tg:GetNext()
	end
		end
	end
end
function c20152605.filter2(c)
	return c:IsSetCard(0xa290) and c:IsType(TYPE_MONSTER) and not c:IsCode(20152605) and c:IsAbleToRemove()
end
function c20152605.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152605.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c20152605.activate2(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c20152605.filter2,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		e:SetLabelObject(tc)
		e:GetHandler():RegisterFlagEffect(20152605,RESET_EVENT+0x1e60000,0,1)
		tc:RegisterFlagEffect(20152605,RESET_EVENT+0x1fe0000,0,1)
	else
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ShuffleDeck(tp)
	end
end