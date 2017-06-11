--星薙冰姬·荧泉
function c10960009.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x357),2,true)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10960009,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(2,10960009)
	e1:SetTarget(c10960009.target)
	e1:SetOperation(c10960009.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1e0)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(2,10960009)
	e2:SetCost(c10960009.spcost)
	e2:SetTarget(c10960009.sptg)
	e2:SetOperation(c10960009.spop)
	c:RegisterEffect(e2)
    --Special Summon
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_POSITION)
    e3:SetType(EFFECT_TYPE_QUICK_O)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetHintTiming(0,0x1e0)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCost(c10960009.cost)
    e3:SetOperation(c10960009.posop)
    c:RegisterEffect(e3)
	--special summon rule
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCountLimit(1)
	e4:SetCondition(c10960009.sprcon)
	e4:SetOperation(c10960009.sprop)
	c:RegisterEffect(e4)	
end
function c10960009.filter(c)
	return c:IsSetCard(0x357) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c10960009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10960009.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c10960009.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10960009.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c10960009.dfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x357)
end
function c10960009.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10960009.dfilter,tp,LOCATION_EXTRA,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10960009.dfilter,tp,LOCATION_EXTRA,0,2,2,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c10960009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10960009.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c10960009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsReleasable() end
    Duel.Release(e:GetHandler(),REASON_COST)
end
function c10960009.pfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x357)
end
function c10960009.posop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c10960009.pfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    Duel.ChangePosition(g,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
function c10960009.spfilter1(c,e,tp)
	return  c:IsSetCard(0x357) and c:IsReleasable() and c:IsCanBeFusionMaterial(e,true)
		and Duel.IsExistingMatchingCard(c10960009.spfilter2,tp,LOCATION_MZONE,0,1,c,e)
end
function c10960009.spfilter2(c,e)
	return c:IsSetCard(0x357)  and c:IsCanBeFusionMaterial(e,true) and c:IsReleasable() 
end
function c10960009.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c10960009.spfilter1,tp,LOCATION_MZONE,0,1,nil,c,tp)
end
function c10960009.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10960009,1))
	local g1=Duel.SelectMatchingCard(tp,c10960009.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,e:GetHandler(),tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10960009,2))
	local g2=Duel.SelectMatchingCard(tp,c10960009.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),e:GetHandler())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Release(g1,REASON_COST)
end
