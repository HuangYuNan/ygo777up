--操符「少女文乐」
function c1012.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1012+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c1012.activate)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1012,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,0x1e0)
	e2:SetTarget(c1012.mtg)
	e2:SetOperation(c1012.mop)
	c:RegisterEffect(e2)
	--SP
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1012,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c1012.spcon)
	e3:SetTarget(c1012.sptg)
	e3:SetOperation(c1012.spop)
	c:RegisterEffect(e3)
end
function c1012.filter(c)
	return c:IsSetCard(0x989) and c:IsType(TYPE_MONSTER) and  c:IsAbleToHand()
end
function c1012.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c1012.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(1012,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c1012.mfilter(c)
	return  c:IsSetCard(0x989) and c:IsFaceup()
end
function c1012.mtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c1012.mfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1012.mfilter,tp,LOCATION_MZONE,0,1,nil) and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)	end
	local g=Duel.SelectTarget(tp,c1012.mfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c1012.mop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e)  then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then 
	if Duel.SelectYesNo(tp,aux.Stringid(1012,3)) then
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if  tc:IsRelateToEffect(e)   then
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
	Duel.MoveSequence(tc,nseq)
	end
	else 
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if  tc:IsFaceup(e) then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		end
	end	
    elseif  Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if  tc:IsRelateToEffect(e)   then
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
	Duel.MoveSequence(tc,nseq)
	end
	elseif  Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if  tc:IsFaceup(e) then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		end
	end
        Duel.RaiseSingleEvent(tc,1001,e,0,tp,0,0)
		 Duel.RaiseEvent(e:GetHandler(),1003,e,0,tp,0,0)
end
function c1012.spcon(e,tp,eg,ep,ev,re,r,rp)
	return  tp==Duel.GetTurnPlayer()
end
function c1012.spfilter(c,e,tp)
	return c:IsFaceup() and c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS  and c:IsSetCard(0x989)
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1012.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and  c1012.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c1012.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp)
    and Duel.GetLocationCount(tp,LOCATION_MZONE)>0	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1012.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1012.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		 Duel.RaiseSingleEvent(tc,1001,e,0,tp,0,0)
		 Duel.RaiseEvent(e:GetHandler(),1003,e,0,tp,0,0)
	end
end
	