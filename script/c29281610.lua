--モノ・シンクロン
function c29281610.initial_effect(c)
    c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281610,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_TO_HAND)
    e1:SetCountLimit(1,29281610)
    e1:SetCost(c29281610.spcost)
    e1:SetCondition(c29281610.condition2)
    e1:SetTarget(c29281610.target2)
    e1:SetOperation(c29281610.operation2)
    c:RegisterEffect(e1)
    --token
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(29281610,1))
    e11:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
    e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e11:SetCode(29281400)
    e11:SetCountLimit(1,29281611)
    e11:SetCost(c29281610.cost)
    e11:SetTarget(c29281610.target)
    e11:SetOperation(c29281610.operation)
    c:RegisterEffect(e11)
    --synchro custom
    local e10=Effect.CreateEffect(c)
    e10:SetType(EFFECT_TYPE_SINGLE)
    e10:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
    e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e10:SetTarget(c29281610.syntg)
    e10:SetValue(1)
    e10:SetOperation(c29281610.synop)
    c:RegisterEffect(e10)
end
function c29281610.filter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c29281610.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29281610.filter,tp,LOCATION_GRAVE,0,3,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectMatchingCard(tp,c29281610.filter,tp,LOCATION_GRAVE,0,3,3,nil)
    Duel.SendtoDeck(g,nil,3,REASON_COST)
end
function c29281610.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c29281610.operation(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
function c29281610.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281610.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,c29281610.filter2,1,nil) end
    local g=Duel.SelectReleaseGroup(tp,c29281610.filter2,1,1,nil)
    Duel.Release(g,REASON_COST)
end
c29281610.tuner_filter=aux.FALSE
function c29281610.synfilter(c,syncard,tuner,f)
    return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard,tuner)
        and c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and (f==nil or f(c))
end
function c29281610.syntg(e,syncard,f,minc,maxc)
    local c=e:GetHandler()
    local lv=syncard:GetLevel()/2-1
    if lv<=0 then return false end
    local g=Duel.GetMatchingGroup(c29281610.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
    return lv>=minc and lv<=maxc and g:GetCount()>=lv
end
function c29281610.synop(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc,maxc)
    local c=e:GetHandler()
    local lv=syncard:GetLevel()/2-1
    local g=Duel.GetMatchingGroup(c29281610.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
    local sg=g:Select(tp,lv,lv,nil)
    Duel.SetSynchroMaterial(sg)
end
function c29281610.condition2(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation(LOCATION_DECK)
end
function c29281610.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29281610.operation2(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end