--忘却之海的公主
function c66678909.initial_effect(c)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),3,2,nil,nil,5)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local code=e:GetOwner():GetOriginalCode()
			Duel.Hint(HINT_CARD,0,code)
			local g=Duel.GetMatchingGroup(function(c)
				return c:IsSetCard(0x665) and c:IsType(TYPE_MONSTER) end,tp,LOCATION_DECK,0,nil)
			if g:GetCount()>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				g=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
				if g:GetCount()>0 then
					Duel.SendtoHand(g,nil,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,g)
				end
			else
				g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
				Duel.ConfirmCards(1-tp,g)
				Duel.ShuffleDeck(tp)
			end
			e:Reset()
		end)
		Duel.RegisterEffect(e1,tp)
	end)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCondition(c66678909.grcon)
	e5:SetTarget(c66678909.grtg)
	e5:SetOperation(c66678909.grop)
	c:RegisterEffect(e5)
end
function c66678909.grcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>0 and e:GetHandler():GetPreviousLocation()==LOCATION_MZONE
end
function c66678909.grfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c66678909.grtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66678909.grfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66678909.grop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c66678909.grfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end