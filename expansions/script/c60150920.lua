--幻想曲T致命旋律 终焉的乐章
function c60150920.initial_effect(c)
	--synchro summon
    aux.AddSynchroProcedure(c,c60150920.tfilter,aux.NonTuner(c60150920.tfilter),2)
    c:EnableReviveLimit()
	--special summon rule
    local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(60150917,1))
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetCode(EFFECT_SPSUMMON_PROC)
    e12:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
    e12:SetRange(LOCATION_EXTRA)
    e12:SetCondition(c60150920.spcon2)
    e12:SetOperation(c60150920.spop2)
    c:RegisterEffect(e12)
	--destroy
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(73580471,0))
    e1:SetCategory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c60150920.descon)
    e1:SetTarget(c60150920.destg)
    e1:SetOperation(c60150920.desop)
    c:RegisterEffect(e1)
	--handes
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_MZONE)
    e3:SetCondition(c60150920.drcon)
    e3:SetOperation(c60150920.drop)
    c:RegisterEffect(e3)
	--Attribute Dark
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_SINGLE)
    e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e13:SetCode(EFFECT_ADD_ATTRIBUTE)
    e13:SetRange(LOCATION_ONFIELD)
    e13:SetValue(ATTRIBUTE_LIGHT)
    c:RegisterEffect(e13)
	local e14=Effect.CreateEffect(c)
    e14:SetType(EFFECT_TYPE_SINGLE)
    e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e14:SetCode(EFFECT_ADD_RACE)
    e14:SetRange(LOCATION_ONFIELD)
    e14:SetValue(RACE_FIEND)
    c:RegisterEffect(e14)
	--spsummon2
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(58069384,2))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c60150920.spcon)
	e6:SetTarget(c60150920.sptg)
	e6:SetOperation(c60150920.spop)
	c:RegisterEffect(e6)
end
function c60150920.tfilter(c)
    return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c60150920.sprfilter1(c,tp)
    local lv=c:GetLevel()
    return c:IsFaceup() and c:IsType(TYPE_TOKEN) and c:IsSetCard(0x6b23) and c:IsCanBeSynchroMaterial()
        and Duel.IsExistingMatchingCard(c60150920.sprfilter2,tp,LOCATION_MZONE,0,1,nil,lv) 
		or (c:IsFaceup() and c:IsType(TYPE_TOKEN) and c:IsSetCard(0x6b23) and lv==10)
end
function c60150920.sprfilter2(c,lv)
    return c:IsFaceup() and c:GetLevel()~=lv and c:GetLevel()+lv==10 and c:IsType(TYPE_TOKEN)
	and c:IsSetCard(0x6b23) and c:IsCanBeSynchroMaterial()
end
function c60150920.spcon2(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
        and Duel.IsExistingMatchingCard(c60150920.sprfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c60150920.spop2(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
    local g1=Duel.SelectMatchingCard(tp,c60150920.sprfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
    local g2=Duel.SelectMatchingCard(tp,c60150920.sprfilter2,tp,LOCATION_MZONE,0,1,1,nil,g1:GetFirst():GetLevel())
    g1:Merge(g2)
    Duel.Release(g1,REASON_COST)
end
function c60150920.filter(c)
    return (c:GetLevel()~=10 or c:IsType(TYPE_SPELL+TYPE_TRAP)) and (c:IsAbleToDeck() or c:IsAbleToExtra())
end
function c60150920.descon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c60150920.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c60150920.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    local g=Duel.GetMatchingGroup(c60150920.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c60150920.desop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c60150920.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    if g:GetCount()>0 then
        Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
    end
end
function c60150920.cfilter(c,tp)
    return c:IsControler(1-tp) and c:IsPreviousLocation(LOCATION_DECK+LOCATION_GRAVE)
end
function c60150920.drcon(e,tp,eg,ep,ev,re,r,rp)
    return eg:IsExists(c60150920.cfilter,1,nil,tp) and Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c60150920.drop(e,tp,eg,ep,ev,re,r,rp)
    if e:GetLabel()==0 then
        Duel.Hint(HINT_CARD,0,60150920)
		Duel.Damage(1-tp,1000,REASON_EFFECT)
    end
end
function c60150920.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetPreviousControler()==tp
end
function c60150920.spfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x6b23) and c:IsFaceup()
end
function c60150920.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.IsExistingMatchingCard(c60150920.spfilter,tp,0,LOCATION_DECK,1,nil) end
end
function c60150920.spop(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
    Duel.ConfirmCards(tp,cg)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150917,3))
	local g=Duel.SelectMatchingCard(tp,c60150920.spfilter,tp,0,LOCATION_DECK,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(1-tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(1-tp,1)
	end
end