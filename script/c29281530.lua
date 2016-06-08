--ダンディライオン
function c29281530.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281530,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_DELAY)
	e1:SetCode(29281400)
	e1:SetCountLimit(1,29281530)
	e1:SetTarget(c29281530.target)
	e1:SetOperation(c29281530.operation)
	c:RegisterEffect(e1)
	--multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281530,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281530)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281530.target2)
	e10:SetOperation(c29281530.mtop)
	c:RegisterEffect(e10)
end
function c29281530.filter5(c)
	return c:IsSetCard(0x3da) and c:IsAbleToHand()
end
function c29281530.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29281530.filter5,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29281530.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c29281530.filter5,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c29281530.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281530.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281530.sumfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29281530.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281530.sumfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c29281530.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281530.filter1,nil)
	   if g:GetCount()>0 then
			Duel.MoveSequence(back:GetFirst(),1)
			local g1=Duel.SelectMatchingCard(tp,c29281530.sumfilter,tp,LOCATION_DECK,0,1,1,nil)
			if g1:GetCount()>0 then
			   Duel.SendtoHand(g1,nil,REASON_EFFECT)
			   Duel.ConfirmCards(1-tp,g1)
			end
			local tg=g:GetFirst()
			Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
	   end
end