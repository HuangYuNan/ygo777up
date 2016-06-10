--蔷薇的统领者
function c37564021.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--特招方法
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(1)
	e2:SetCountLimit(1,375640211+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c37564021.spcon)
	e2:SetOperation(c37564021.spop)
	c:RegisterEffect(e2)
	--变超量
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetOriginalCode()==37564021
	end)
	e3:SetTarget(c37564021.tg)
	e3:SetOperation(c37564021.op)
	c:RegisterEffect(e3)
end
function c37564021.spfilter1(c)
	return c:IsCode(37564019) and c:IsAbleToRemoveAsCost() 
end
function c37564021.spfilter2(c)
	return c:IsCode(37564020) and c:IsAbleToRemoveAsCost() 
end
function c37564021.spfilter3(c)
	return c:IsCode(37564017) and c:IsAbleToRemoveAsCost() 
end
function c37564021.spfilter4(c)
	return c:IsCode(37564014) and c:IsAbleToRemoveAsCost() 
end
function c37564021.spfilter5(c)
	return c:IsCode(37564015) and c:IsAbleToRemoveAsCost() 
end
function c37564021.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564021.spfilter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c37564021.spfilter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c37564021.spfilter3,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c37564021.spfilter4,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c37564021.spfilter5,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
end
function c37564021.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c37564021.spfilter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c37564021.spfilter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c37564021.spfilter3,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g4=Duel.SelectMatchingCard(tp,c37564021.spfilter4,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g5=Duel.SelectMatchingCard(tp,c37564021.spfilter5,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	g1:Merge(g5)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c37564021.filter(c,e,tp)
	return c:IsSetCard(0x770) and e:GetHandler():IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c37564021.counterfilter(c)
	return c:IsSetCard(0x770) or c:GetSummonLocation()~=LOCATION_EXTRA
end
function c37564021.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c37564021.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564021.matfilter(c)
	return c:IsType(TYPE_XYZ)
end
function c37564021.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=e:GetHandler()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564021.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
		if Duel.IsExistingMatchingCard(c37564021.matfilter,tp,LOCATION_EXTRA,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(37564021,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(37564021,1))
			local mg2=Duel.SelectMatchingCard(tp,c37564021.matfilter,tp,LOCATION_EXTRA,0,1,7,nil)
			Duel.HintSelection(mg2)
			Duel.Overlay(sc,mg2)
		end
	end
end
