--AIW·仙境的爱丽丝
function c66619901.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(1,16601+EFFECT_COUNT_CODE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c66619901.thtg)
	e1:SetOperation(c66619901.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c66619901.filter1(c)
	return c:IsCode(66619916) and c:IsAbleToHand()
end
function c66619901.filter2(c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c66619901.cfilter(c)
	return c:IsFaceup() and c:IsCode(66619916) and c:IsAbleToGrave()
end
function c66619901.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_GRAVE) and chkc:IsControler(tp) and c66619901.filter1(chkc) end
	local b1=Duel.IsExistingTarget(c66619901.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(c66619901.filter2,tp,LOCATION_DECK,0,1,nil) and Duel.IsExistingTarget(c66619904.darwfilter,tp,LOCATION_ONFIELD,0,1,nil)
	if chk==0 then return b1 or b2 and Duel.IsExistingMatchingCard(c66619901.filter2,tp,LOCATION_ONFIELD,0,1,nil) end
	local op=0
	if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(66619901,0),aux.Stringid(66619901,1))
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(66619901,0))
	else op=Duel.SelectOption(tp,aux.Stringid(66619901,1))+1 end
	e:SetLabel(op)
	if op==0 then
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		local g=Duel.SelectMatchingCard(tp,c66619901.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_EFFECT)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end
function c66619901.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c66619901.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c66619901.filter2,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end