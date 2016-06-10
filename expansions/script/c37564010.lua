--元素精灵·德库兹克
function c37564010.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,37564010)
	e1:SetCost(c37564010.cost)
	e1:SetTarget(c37564010.tg)
	e1:SetOperation(c37564010.op)
	c:RegisterEffect(e1)
end
function c37564010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c37564010.filter(c,e,tp)
	local rk=c:GetRank()
	return c:IsType(TYPE_XYZ) and c:IsFaceup() and c:IsSetCard(0x770) and c:GetOverlayCount()>0
		and Duel.IsExistingMatchingCard(c37564010.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,rk)
end
function c37564010.spfilter(c,e,tp,rk)
	return c:IsType(TYPE_XYZ) and c:GetRank()==rk+1 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and c:IsSetCard(0x770)
end
function c37564010.chkfilter(c,tc)
	local rk=tc:GetRank()
	return c:IsFaceup() and c:GetRank()==rk-1
end
function c37564010.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c37564010.chkfilter(chkc,e:GetLabelObject()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c37564010.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(37564010,0))
	local g=Duel.SelectTarget(tp,c37564010.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:SetLabelObject(g:GetFirst())
end
function c37564010.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local rk=tc:GetRank()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564010.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,rk)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,tc)
		Duel.SpecialSummon(g,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end