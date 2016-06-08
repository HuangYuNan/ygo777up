--星見獣ガリス
function c29281480.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281480,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c29281480.spcost)
	e1:SetTarget(c29281480.sptarget)
	e1:SetOperation(c29281480.spoperation)
	c:RegisterEffect(e1)
	--multi attack
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(29281480,2))
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCountLimit(1)
	e11:SetRange(LOCATION_MZONE)
	e11:SetTarget(c29281480.target2)
	e11:SetOperation(c29281480.mtop)
	c:RegisterEffect(e11)
end
function c29281480.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c29281480.sptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c29281480.filter1(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281480.spoperation(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveSequence(back:GetFirst(),1)
		if tc:IsType(TYPE_MONSTER) and tc:IsSetCard(0x3da) then
			   if c:IsRelateToEffect(e) then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
		   else
			   if c:IsRelateToEffect(e) then Duel.Destroy(c,REASON_EFFECT) end
		end
		Duel.RaiseSingleEvent(back:GetFirst(),29281400,e,0,0,0,0)
	end
end
function c29281480.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281480.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281480.filter1,nil)
	   if g:GetCount()>0 then
		  local e8=Effect.CreateEffect(e:GetHandler())
		  e8:SetType(EFFECT_TYPE_SINGLE)
		  e8:SetCode(EFFECT_EXTRA_ATTACK)
		  e8:SetValue(1)
		  e8:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		  e:GetHandler():RegisterEffect(e8)
			Duel.MoveSequence(back:GetFirst(),1)
		   local tg=g:GetFirst()
		   Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
		end
end