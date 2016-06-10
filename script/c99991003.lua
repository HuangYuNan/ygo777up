--伦敦人形
function c99991003.initial_effect(c)
    c:SetUniqueOnField(1,0,99991003)
    --spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99991003,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(99991003)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e1:SetCondition(c99991003.spcon)
	e1:SetTarget(c99991003.sptg)
	e1:SetOperation(c99991003.spop)
	c:RegisterEffect(e1)
	--yami
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UNRELEASABLE_SUM)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetValue(1)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c99991003.lktg)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(1)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c99991003.lktg)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e6)
end
function c99991003.spcon(e,tp,eg,ep,ev,re,r,rp)
	return  re:GetHandler():IsControler(tp) 
end
function c99991003.spfilter(c,e,tp,ft)
	return  c:IsType(TYPE_MONSTER) and c:IsSetCard(0x2e6)  and(c:IsCanBeSpecialSummoned(e,0,tp,false,false) or ft>0)
end
function c99991003.tdtfilter(c)
	return c:IsAbleToDeck()
end
function c99991003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or ft>0)
		and Duel.IsExistingMatchingCard(c99991003.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,ft) and 
		Duel.IsExistingMatchingCard(c99991003.tdfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c99991003.spop(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft1<=0 and ft2<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c99991003.tdtfilter,tp,LOCATION_HAND,0,1,1,nil)
	local hc=g:GetFirst()
	if hc  and Duel.SendtoDeck(hc,nil,2,REASON_EFFECT)>0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c99991003.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ft2)
	local tc=g:GetFirst()
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
		end
	end
end
function c99991003.lktg(e,c)
   local g=(4-e:GetHandler():GetSequence())
	return c:GetSequence()==g and c:GetControler()~=e:GetHandler():GetControler()
end