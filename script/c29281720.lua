--ダンディライオン
function c29281720.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281720,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_DELAY)
	e1:SetCode(29281400)
	e1:SetCountLimit(1,29281720)
	e1:SetTarget(c29281720.target)
	e1:SetOperation(c29281720.operation)
	c:RegisterEffect(e1)
	--multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281720,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281721)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281720.target2)
	e10:SetOperation(c29281720.mtop)
	c:RegisterEffect(e10)
end
function c29281720.filter5(c)
	return c:IsSetCard(0x3da) and c:IsAbleToDeck()
end
function c29281720.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c29281720.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==0 then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,c29281720.filter5,p,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
end
function c29281720.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281720.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281720.sumfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c29281720.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281720.sumfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c29281720.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281720.filter2,nil)
	   if g:GetCount()>0 then
			Duel.MoveSequence(back:GetFirst(),1)
			local g1=Duel.SelectMatchingCard(tp,c29281720.sumfilter,tp,LOCATION_DECK,0,1,1,nil)
			if g1:GetCount()>0 then
			   Duel.SendtoGrave(g1,REASON_EFFECT)
			end
			local tg=g:GetFirst()
			Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
	   end
end