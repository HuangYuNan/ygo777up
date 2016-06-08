--hongfengsanluo
function c29281670.initial_effect(c)
	aux.AddSynchroProcedure(c,c29281670.tfilter,aux.NonTuner(Card.IsSetCard,0x3da),1)
	c:EnableReviveLimit()	
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281670,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c29281670.atcon)
	e1:SetTarget(c29281670.target)
	e1:SetOperation(c29281670.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29281670,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c29281670.thcon)
	e2:SetTarget(c29281670.thtg)
	e2:SetOperation(c29281670.thop)
	c:RegisterEffect(e2)
end
function c29281670.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c29281670.filter1(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281670.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
end
function c29281670.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanDiscardDeck(tp,5) then return end
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5):Filter(c29281670.filter1,nil)
	Duel.ShuffleDeck(tp)
	--local tc=g:GetFirst()
	  if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.BreakEffect()
		Duel.Damage(1-tp,g:GetCount()*200,REASON_EFFECT)
	  end
end
function c29281670.tfilter(c)
	return c:IsSetCard(0x3da)
end
function c29281670.thcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and e:GetHandler():GetPreviousControler()==tp
end
function c29281670.thfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c29281670.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c29281670.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c29281670.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c29281670.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c29281670.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end