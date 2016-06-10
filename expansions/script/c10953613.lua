--初春饰利
function c10953613.initial_effect(c)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10953613,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,10953613)
	e4:SetCost(c10953613.spcost)
	e4:SetTarget(c10953613.sptg1)
	e4:SetOperation(c10953613.spop1)
	c:RegisterEffect(e4)
end
function c10953613.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c10953613.spfilter1(c,e,tp)
	return c:IsSetCard(0x23c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10953613.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c10953613.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c10953613.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c10953613.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c10953613.spop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end