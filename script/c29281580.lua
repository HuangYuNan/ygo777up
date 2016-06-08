--ダンディライオン
function c29281580.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281580,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_DELAY)
	e1:SetCode(29281400)
	e1:SetCountLimit(1,29281580)
	e1:SetTarget(c29281580.target)
	e1:SetOperation(c29281580.operation)
	c:RegisterEffect(e1)
	--multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281580,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281580)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281580.target2)
	e10:SetOperation(c29281580.mtop)
	c:RegisterEffect(e10)
end
function c29281580.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c29281580.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c29281580.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c29281580.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c29281580.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c29281580.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c29281580.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281580.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281580.sumfilter(c,e,tp)
	return c:GetCode()==29281580 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29281580.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281580.sumfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
end
function c29281580.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281480.filter1,nil)
	   if g:GetCount()>0 then
			Duel.MoveSequence(back:GetFirst(),1)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g1=Duel.SelectMatchingCard(tp,c29281580.sumfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
			if g1:GetCount()>0 then
			   Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
			end
			local tg=g:GetFirst()
			Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
	   end
end