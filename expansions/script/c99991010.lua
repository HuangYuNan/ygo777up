--人形馆
function c99991010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetDescription(aux.Stringid(99991010,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c99991010.target)
	e2:SetOperation(c99991010.operation)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
    c:RegisterEffect(e2)
	--atk\def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c99991010.tg)
	e3:SetValue(c99991010.val)
	c:RegisterEffect(e3)
    local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--sp
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(99991003,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTarget(c99991010.target2)
	e5:SetOperation(c99991010.operation2)
	e5:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
    c:RegisterEffect(e5)
end
function c99991010.filter1(c)
	return c:IsSetCard(0x2e6) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c99991010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c599991010.filter1(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingTarget(c99991010.filter1,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectTarget(tp,c99991010.filter1,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c99991010.filter2(c,e,tp)
	return c:IsSetCard(0x2e6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsType(TYPE_MONSTER)
	and c:GetLevel()==1
end
function c99991010.tgfilter(c,e)
	return not c:IsRelateToEffect(e)
end
function c99991010.operation(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e)  then return end
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if tg:IsExists(c99991010.tgfilter,1,nil,e) then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c99991010.tg(e,c)
	return c:IsSetCard(0x2e6)
end
function c99991010.filter3(c)
	return c:IsFaceup() and c:IsSetCard(0x2e6)
end
function c99991010.val(e,c)
	return Duel.GetMatchingGroupCount(c99991010.filter3,0,LOCATION_MZONE,LOCATION_MZONE,nil)*100
end
function c99991010.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
		and Duel.IsExistingMatchingCard(c99991010.filter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_SZONE)
end
function c99991010.operation2(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft1<=0 and ft2<=0 then return end
	local g1=Duel.SelectMatchingCard(tp,c99991003.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=g1:GetFirst()
	if tc then
	if ft1>0 and ft2<=0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)  then 
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    elseif ft1<=0 and ft2>0 then
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
	tc:CompleteProcedure()
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
	if Duel.SelectYesNo(tp,aux.Stringid(99991001,0)) and ft2>0 and  Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) then
	local g2=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc2=g2:GetFirst()
	if tc2 then
	Duel.MoveToField(tc2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fc0000)
		e2:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc2:RegisterEffect(e2)
		 Duel.RaiseEvent(e:GetHandler(),99991003,e,0,tp,0,0)
        Duel.RaiseSingleEvent(tc2,99991001,e,0,tp,0,0)
end
end
end
end
