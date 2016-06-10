--七色的人形使 爱丽丝·玛格特罗伊德
function c99991017.initial_effect(c)
    c:SetUniqueOnField(1,0,99991017)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x2e6),1,2)
	c:EnableReviveLimit()
	--move
	local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(99991012,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(c99991017.mcost)
	e1:SetTarget(c99991017.mtg)
	e1:SetOperation(c99991017.mop)
	c:RegisterEffect(e1)
	--sp1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99991012,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetHintTiming(0,0x1e0)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c99991017.mcost)
	e2:SetTarget(c99991017.sptg1)
	e2:SetOperation(c99991017.spop1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetCondition(c99991017.tgcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(c99991017.effval)
	c:RegisterEffect(e4)
	--sp2
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(99991017,0))
	e5:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
    e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCost(c99991017.spcost)
	e5:SetTarget(c99991017.sptg2)
	e5:SetOperation(c99991017.spop2)
	c:RegisterEffect(e5)
end
function c99991017.mcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c99991017.filter(c)
	return c:IsLevelAbove(1) and  c:IsSetCard(0x2e6) and c:IsFaceup()
end
function c99991017.mtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
     if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c99991017.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99991017.filter,tp,LOCATION_MZONE,0,1,nil) and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)	end
	local g=Duel.SelectTarget(tp,c99991017.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c99991017.mop(e,tp,eg,ep,ev,re,r,rp)
   if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown()  then return end
   local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then 
	if Duel.SelectYesNo(tp,aux.Stringid(99991012,3)) then 
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
	 Duel.RaiseEvent(e:GetHandler(),99991003,e,0,tp,0,0)
        Duel.RaiseSingleEvent(tc,99991001,e,0,tp,0,0)
end
function c99991017.spfilter(c,e,tp)
	return c:IsFaceup() and c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS  and c:IsSetCard(0x2e6)
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c99991017.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and  c99991017.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c99991017.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local g=Duel.SelectTarget(tp,c99991017.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c99991017.spop1(e,tp,eg,ep,ev,re,r,rp)
	   if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown()  then return end
	 if  Duel.GetLocationCount(tp,LOCATION_MZONE)<=0  then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		 Duel.RaiseEvent(e:GetHandler(),99991003,e,0,tp,0,0)
        Duel.RaiseSingleEvent(tc,99991001,e,0,tp,0,0)
end
end
function c99991017.tgcon(e)
	return Duel.IsExistingMatchingCard(c99991017.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c99991017.effval(e,te,tp)
	return tp~=e:GetHandlerPlayer()
end
function c99991017.spfilter2(c,e,tp,ft)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x2e6) and (c:IsCanBeSpecialSummoned(e,0,tp,false,false) or ft>0)
end
function c99991017.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c99991017.tdfilter(c)
	return  c:IsSetCard(0x2e6)   and c:IsAbleToDeck() and c:IsFaceup() 
end
function c99991017.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_ONFIELD)
	local ft2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(tp) and c99991017.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99991017.tdfilter,tp,LOCATION_ONFIELD,0,1,nil) and ft>-2 
    and Duel.IsExistingMatchingCard(c99991017.spfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,ft2)	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c99991017.tdfilter,tp,LOCATION_ONFIELD,0,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,g:GetCount(),tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c99991017.spop2(e,tp,eg,ep,ev,re,r,rp)
    local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		if Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)>0 and (ft1>0
    or ft2>0)	then
	local g=Duel.SelectMatchingCard(tp,c99991017.spfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,tg:GetCount(),tg:GetCount(),nil,e,tp,ft2)
		local tc=g:GetFirst()
		while tc do
	if ft1>0 and ft2<=0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)  then 
	if ft1<=0 then return end
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    elseif ((ft1<=0 and ft2>0) or  Duel.IsPlayerAffectedByEffect(tp,59822133))then
	if ft2<=0 then return end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
    elseif ft1>0 and ft2>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and  Duel.SelectYesNo(tp,aux.Stringid(99991003,0)) then
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
		end
end
end
