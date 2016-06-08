--hongfengsanluo
function c29281630.initial_effect(c)
	aux.AddSynchroProcedure(c,c29281630.tfilter,aux.NonTuner(Card.IsSetCard,0x3da),1)
	c:EnableReviveLimit()
	--multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281630,0))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281630)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281630.target2)
	e10:SetOperation(c29281630.mtop)
	c:RegisterEffect(e10)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281630,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,29281631)
	e1:SetCondition(c29281630.spcon)
	e1:SetTarget(c29281630.sptg)
	e1:SetOperation(c29281630.spop)
	c:RegisterEffect(e1)
end
function c29281630.tfilter(c)
	return c:IsSetCard(0x3da)
end
function c29281630.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281630.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281630.filter5(c)
	return c:IsAbleToRemove()
end
function c29281630.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281630.filter2,tp,LOCATION_MZONE,0,1,nil) end
end
function c29281630.sumfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281630.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281630.filter2,nil)
	   if g:GetCount()>0 then
			Duel.MoveSequence(back:GetFirst(),1)
		local g1=Duel.SelectMatchingCard(tp,c29281630.filter5,tp,0,LOCATION_GRAVE,1,2,nil)
		Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
			local tg=g:GetFirst()
			Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
	   end
end
function c29281630.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_MZONE
end
function c29281630.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29281630.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,2) then return end
	Duel.ConfirmDecktop(tp,2)
	local g=Duel.GetDecktopGroup(tp,2):Filter(c29281630.filter2,nil)
	   if g:GetCount()>1 then
	   Duel.SortDecktop(tp,tp,2)
	   for i=1,2 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	   if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		   local e1=Effect.CreateEffect(e:GetHandler())
		   e1:SetType(EFFECT_TYPE_SINGLE)
		   e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		   e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		   e1:SetReset(RESET_EVENT+0x47e0000)
		   e1:SetValue(LOCATION_DECKBOT)
		   e:GetHandler():RegisterEffect(e1,true)
	   end
	   else
	   Duel.SortDecktop(tp,tp,2)
	   for i=1,2 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	   end
end
