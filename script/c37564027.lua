--元素引导者·Scorpiour
function c37564027.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,5,4,nil,nil,5)
	--ind
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c37564027.indcon)
	e1:SetValue(c37564027.immfilter)
	c:RegisterEffect(e1)
--ss
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564027,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,37564027)
	e3:SetCost(c37564027.sscost)
	e3:SetTarget(c37564027.sstg)
	e3:SetOperation(c37564027.ssop)
	c:RegisterEffect(e3)
--xm
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564027,1))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetCost(c37564027.xmcon)
	e4:SetTarget(c37564027.xmtg)
	e4:SetOperation(c37564027.xmop)
	c:RegisterEffect(e4)
end
function c37564027.immfilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c37564027.indcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c37564027.indfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c37564027.indfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x770) and c:IsType(TYPE_XYZ) and c:GetRank()==4
end
function c37564027.sscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37564027.ssfilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:GetRank()==4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564027.sstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c37564027.ssfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c37564027.ssfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c37564027.ssfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c37564027.ssop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c37564027.filter1(c)
	return c:IsSetCard(0x770) 
end
function c37564027.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetRank()==4
end
function c37564027.xmfilter(c)
	return c:IsSetCard(0x770) and c:IsType(TYPE_XYZ) and c:GetRank()==4
end
function c37564027.xmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(c37564027.xmfilter,1,nil)
end
function c37564027.xmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c37564027.filter2,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingMatchingCard(c37564027.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c37564027.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c37564027.xmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e)then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(37564027,2))
		local g=Duel.SelectMatchingCard(tp,c37564027.filter1,tp,LOCATION_DECK,0,1,1,nil)
		local mg=g:GetFirst()
		if g:GetCount()>0 then
		Duel.Overlay(tc,mg)
		end
	end
end


