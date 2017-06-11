--凋叶棕-为了hakanakihito?们
function c29200105.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c29200105.target)
    e1:SetOperation(c29200105.activate)
    c:RegisterEffect(e1)
end
function c29200105.tfilter(c,def,code,e,tp)
    return c:IsSetCard(0x53e0) and not c:IsCode(code) and c:GetDEFENSE()==def and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29200105.filter(c,e,tp)
    return c:IsFaceup() and c:IsSetCard(0x53e0)
        and Duel.IsExistingMatchingCard(c29200105.tfilter,tp,LOCATION_DECK,0,1,nil,c:GetDEFENSE(),c:GetCode(),e,tp)
end
function c29200105.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c29200105.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c29200105.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local g=Duel.SelectTarget(tp,c29200105.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c29200105.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local tc=Duel.GetFirstTarget()
    if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local sg=Duel.SelectMatchingCard(tp,c29200105.tfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetDEFENSE(),tc:GetCode(),e,tp)
    if sg:GetCount()>0 then
        Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
    end
end

