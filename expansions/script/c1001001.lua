--奇迹小镇-渚
function c1001001.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,10010011)
	e1:SetCondition(c1001001.spcon1)
	e1:SetTarget(c1001001.sptg1)
	e1:SetOperation(c1001001.spop1)
	c:RegisterEffect(e1)
	--tohand or SPECIAL_SUMMON
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1001001,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,10010012)
	e1:SetCondition(c1001001.spcon2)
	e1:SetTarget(c1001001.sptg2)
	e1:SetOperation(c1001001.spop2)
	c:RegisterEffect(e1)
end
function c1001001.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonLocation()==LOCATION_GRAVE
end
function c1001001.spfilter(c,e,tp,ft)
	return c:IsFaceup() and c:IsSetCard(0x9204) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1001001.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c1001001.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1001001.spfilter,tp,LOCATION_REMOVED,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1001001.spfilter,tp,LOCATION_REMOVED,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1001001.spop1(e,tp,eg,ep,ev,re,r,rp)
	 local tc=Duel.GetFirstTarget()
	 if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1001001.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_FUSION
end
function c1001001.filter2(c,e,tp,ft)
	return c:IsSetCard(0x9204) and (c:IsAbleToHand() or (ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c1001001.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c1001001.filter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c1001001.spop2(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1001001.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if tc then
		if ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectYesNo(tp,aux.Stringid(1001001,1))) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
