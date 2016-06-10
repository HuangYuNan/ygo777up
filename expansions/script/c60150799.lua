--乖离进化？！
function c60150799.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60150799,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,60150799+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c60150799.target)
	e1:SetOperation(c60150799.activate)
	c:RegisterEffect(e1)
	--Activate
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(60150799,1))
	e12:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e12:SetType(EFFECT_TYPE_ACTIVATE)
	e12:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e12:SetCode(EVENT_FREE_CHAIN)
	e12:SetHintTiming(0,0x1e0)
	e12:SetCountLimit(1,60150799+EFFECT_COUNT_CODE_OATH)
	e12:SetTarget(c60150799.target2)
	e12:SetOperation(c60150799.activate2)
	c:RegisterEffect(e12)
end
function c60150799.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xb22) and c:IsType(TYPE_FUSION)
		and Duel.IsExistingMatchingCard(c60150799.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,nil)
end
function c60150799.filter2(c,e,tp,mc,rk)
	return c:IsSetCard(0xb22) and c:IsType(TYPE_XYZ) and c:GetRank()==11 and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c60150799.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c60150799.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c60150799.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c60150799.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c60150799.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60150799.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,nil)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c60150799.filter(c)
	return c:IsFaceup() and c:IsType(0xb22) and c:IsType(TYPE_XYZ) and c:GetRank()==11 
		and c:IsAbleToExtra() and c:GetOverlayCount()>0
end
function c60150799.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60150799.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150799.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c60150799.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c60150799.spfilter(c,e,tp)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsLocation(LOCATION_REMOVED)) and c:IsType(TYPE_FUSION) and c:IsSetCard(0xb22)
	and c:IsCanBeSpecialSummoned(e,0,tp,tp,true,false,POS_FACEUP) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c60150799.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetOverlayGroup()
	Duel.SendtoGrave(mg,REASON_EFFECT)
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)>0 then
		local g=mg:Filter(c60150799.spfilter,nil,e,tp)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft>0 and g:GetCount()>0 then
			if g:GetCount()>ft then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				g=g:Select(tp,ft,ft,nil)
			end
			local tc=g:GetFirst()
				Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
			Duel.SpecialSummonComplete()
		end
	end
end