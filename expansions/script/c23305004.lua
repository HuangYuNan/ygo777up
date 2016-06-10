--魔创龙 十月永恒烈焰
function c23305004.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23305004,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c23305004.otcon)
	e1:SetOperation(c23305004.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e3:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c23305004.spcon)
	e3:SetOperation(c23305004.spop)
	c:RegisterEffect(e3)
	--summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23305004,2))
	e4:SetCategory(CATEGORY_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_HAND)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e4:SetCountLimit(1,23305004)
	e4:SetCondition(c23305004.sumcon)
	e4:SetCost(c23305004.sumcost)
	e4:SetTarget(c23305004.sumtg)
	e4:SetOperation(c23305004.sumop)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(23305004,1))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetCountLimit(1,91100051)
	e5:SetCondition(c23305004.con)
	e5:SetTarget(c23305004.tg)
	e5:SetOperation(c23305004.op)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	e6:SetCondition(c23305004.recon)
	c:RegisterEffect(e6)
end
function c23305004.otfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA or c:IsSetCard(0x996)
end
function c23305004.otcon(e,c)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c23305004.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return c:GetLevel()>6 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.GetTributeCount(c,mg)>0
end
function c23305004.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c23305004.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c23305004.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_DRAGON) and c:IsDiscardable()
end
function c23305004.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23305004.spfilter,tp,LOCATION_HAND,0,1,c)
end
function c23305004.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	Duel.DiscardHand(tp,c23305004.spfilter,1,1,REASON_COST+REASON_DISCARD,c)
end
function c23305004.sumcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c23305004.cfilter(c)
	return c:IsSetCard(0x996) and c:IsAbleToRemoveAsCost()
end
function c23305004.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23305004.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c23305004.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c23305004.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSummonable(true,nil,1) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,e:GetHandler(),1,0,0)
end
function c23305004.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsSummonable(true,nil,1) then
		Duel.Summon(tp,c,true,nil,1)
	end
end
function c23305004.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c23305004.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_COST) and re:IsHasType(0x7f4)
end
function c23305004.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c23305004.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end