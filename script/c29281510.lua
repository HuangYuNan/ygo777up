--魔導雑貨商人
function c29281510.initial_effect(c)
	--flip
	local e10=Effect.CreateEffect(c)
	e10:SetCategory(CATEGORY_TOHAND)
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e10:SetOperation(c29281510.operation)
	c:RegisterEffect(e10)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281510,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c29281510.cost)
	e1:SetTarget(c29281510.target)
	e1:SetOperation(c29281510.operation1)
	c:RegisterEffect(e1)
end
function c29281510.filter1(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_SPELL)
end
--(c29281480.filter1,nil)
function c29281510.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c29281510.filter1,tp,LOCATION_DECK,0,nil)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if dcount==0 then return end
	local t={}
	for i=1,dcount do t[i]=i end
	if g:GetCount()==0 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.ShuffleDeck(tp)
		return
	end
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	while tc do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			spcard=tc
		end
		tc=g:GetNext()
	end
	ac=dcount-seq
	Duel.ConfirmDecktop(tp,ac)
	if spcard:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(spcard,nil,REASON_EFFECT)
		--Duel.SortDecktop(tp,tp,ac)
		for i=1,ac do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
			Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
		end
	else 
		--Duel.SortDecktop(tp,tp,ac)
		for i=1,ac do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
		end 
	end
	--Duel.RaiseSingleEvent(tc,1001,e,0,tp,0,0)
end
function c29281510.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c29281510.filter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c29281510.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c29281510.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.IsExistingTarget(c29281510.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c29281510.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c29281510.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
	end
end