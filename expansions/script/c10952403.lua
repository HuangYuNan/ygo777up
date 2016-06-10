--悠久的使者·莎榭·半月
function c10952403.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,c10952403.mfilter,2,3)
    c:EnableReviveLimit()
    --indes
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetValue(1)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    c:RegisterEffect(e2)
    --spsummon
    local e8=Effect.CreateEffect(c)
    e8:SetDescription(aux.Stringid(10952403,0))
    e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e8:SetRange(LOCATION_MZONE)
    e8:SetCode(EVENT_PHASE+PHASE_END)
    e8:SetCondition(c10952403.condition)
    e8:SetTarget(c10952403.sptg)
    e8:SetOperation(c10952403.spop)
    c:RegisterEffect(e8)
end
function c10952403.mfilter(c)
    return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and not c:IsType(TYPE_NORMAL)
end
function c10952403.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==1-tp
end
function c10952403.filter(c,e,tp,rk)
    return c:GetRank()==rk+1 and c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and e:GetHandler():IsCanBeXyzMaterial(c)
        and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c10952403.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and Duel.IsExistingMatchingCard(c10952403.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler():GetRank()) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c10952403.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
    local c=e:GetHandler()
    if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c10952403.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c:GetRank())
    local sc=g:GetFirst()
    if sc then
        local mg=c:GetOverlayGroup()
        if mg:GetCount()~=0 then
            Duel.Overlay(sc,mg)
        end
        sc:SetMaterial(Group.FromCards(c))
        Duel.Overlay(sc,Group.FromCards(c))
        Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
        sc:CompleteProcedure()
    end
end