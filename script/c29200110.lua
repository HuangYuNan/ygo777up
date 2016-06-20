--凋叶棕-被弃置的小伞怨节
function c29200110.initial_effect(c)
    --spsummon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200110,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_BE_BATTLE_TARGET)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c29200110.condition)
    e1:SetTarget(c29200110.target)
    e1:SetOperation(c29200110.operation)
    c:RegisterEffect(e1)
    --[[--xyz
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29200110,1))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c29200110.spcon)
    e2:SetTarget(c29200110.sptg)
    e2:SetOperation(c29200110.spop)
    c:RegisterEffect(e2)]]
end
c29200110.dyz_utai_list=true
function c29200110.condition(e,tp,eg,ep,ev,re,r,rp)
    local at=Duel.GetAttackTarget()
    return at:IsFaceup() and at:IsControler(tp) and at:IsSetCard(0x53e0)
end
function c29200110.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c29200110.xyzfilter(c,mg)
    return c:IsSetCard(0x53e0) and c:IsXyzSummonable(mg)
end
function c29200110.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
        Duel.Recover(tp,1000,REASON_EFFECT)
        Duel.BreakEffect()
        local xyzg=Duel.GetMatchingGroup(c29200110.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
        if xyzg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(29200110,2)) then
            Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
            local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
            Duel.XyzSummon(tp,xyz,g,1,5)
        end
    elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
        Duel.SendtoGrave(c,REASON_RULE)
    end
end
function c29200110.spcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c29200110.mfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x53e0) and not c:IsType(TYPE_TOKEN)
end
function c29200110.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local g=Duel.GetMatchingGroup(c29200110.mfilter,tp,LOCATION_MZONE,0,nil)
        return Duel.IsExistingMatchingCard(c29200110.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,g)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29200110.spop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c29200110.mfilter,tp,LOCATION_MZONE,0,nil)
    local xyzg=Duel.GetMatchingGroup(c29200110.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
    if xyzg:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
        Duel.XyzSummon(tp,xyz,g,1,5)
    end
end

