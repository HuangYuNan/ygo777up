--奇迹小镇-相乐美佐枝
function c1001011.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c1001011.ffilter1,c1001011.ffilter2,true)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(c1001011.splimit)
	c:RegisterEffect(e2)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c1001011.descon)
	e1:SetTarget(c1001011.destg)
	e1:SetOperation(c1001011.desop)
	c:RegisterEffect(e1)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1001011,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c1001011.tdtg)
	e3:SetOperation(c1001011.tdop)
	c:RegisterEffect(e3)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1001011,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,1001011)
	e3:SetCost(c1001011.spcost)
	e3:SetTarget(c1001011.sptg)
	e3:SetOperation(c1001011.spop)
	c:RegisterEffect(e3)
end
function c1001011.ffilter1(c)
	return c:IsSetCard(0x9204) and c:IsType(TYPE_FUSION)
end
function c1001011.ffilter2(c)
	return c:IsSetCard(0x9204)
end
function c1001011.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c1001011.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c1001011.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c1001011.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1001011.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c1001011.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c1001011.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1001011.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c1001011.tdfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and c:IsAbleToDeck()
end
function c1001011.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1001011.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1001011.tdfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c1001011.tdfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c1001011.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
function c1001011.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1001011.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x9204) and not c:IsCode(1001011) and (c:IsAbleToHand() or (ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c1001011.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED+LOCATION_GRAVE) and chkc:IsControler(tp) and c1001011.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1001011.spfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1001011.spfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1001011.spop(e,tp,eg,ep,ev,re,r,rp)
   local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1001011.spfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,1,nil,e,tp,ft)
	local tc=g:GetFirst()
	if tc then
		if ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectYesNo(tp,aux.Stringid(1001011,2))) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
