--凋叶棕-尽管如此洋馆还是旋转着
function c29200114.initial_effect(c)
    --destroy and set
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetTarget(c29200114.target)
    e1:SetOperation(c29200114.operation)
    c:RegisterEffect(e1)
    --cannot target
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e4:SetValue(aux.tgoval)
    c:RegisterEffect(e4)
    --Activate
    local e15=Effect.CreateEffect(c)
    e15:SetDescription(aux.Stringid(29200114,0))
    e15:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e15:SetType(EFFECT_TYPE_ACTIVATE)
    e15:SetCode(EVENT_ATTACK_ANNOUNCE)
    e15:SetProperty(0,EFFECT_FLAG2_COF)
    e15:SetCondition(c29200114.condition5)
    e15:SetTarget(c29200114.target5)
    e15:SetOperation(c29200114.activate5)
    c:RegisterEffect(e15)
    --Activate8
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29200114,1))
    e10:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e10:SetProperty(0,EFFECT_FLAG2_COF+EFFECT_FLAG_CARD_TARGET)
    e10:SetType(EFFECT_TYPE_ACTIVATE)
    e10:SetCode(EVENT_FREE_CHAIN)
    e10:SetCountLimit(1,29299991)
    e10:SetTarget(c29200114.target8)
    e10:SetOperation(c29200114.activate8)
    c:RegisterEffect(e10)
end
function c29200114.filter8(c,e,tp)
    return c:IsSetCard(0x53e0) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29200114.target8(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c29200114.filter8(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c29200114.filter8,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c29200114.filter8,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c29200114.activate8(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c29200114.condition5(e,tp,eg,ep,ev,re,r,rp)
    return tp~=Duel.GetTurnPlayer()
end
function c29200114.spfilter(c,e,tp)
    return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29200114.target5(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c29200114.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function c29200114.activate5(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummon(tp) then return end
    local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
    local sg=g:RandomSelect(1-tp,1)
    local tc=sg:GetFirst()
    if tc then
        Duel.ConfirmCards(1-tp,tc)
        if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
            Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
        else
            Duel.SendtoGrave(tc,REASON_EFFECT)
        end
    end
end
function c29200114.desfilter(c,tp)
    if c:IsFacedown() or not c:IsDestructable() then return false end
    local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
    if ft==0 and c:IsLocation(LOCATION_SZONE) and c:GetSequence()<5 then
        return Duel.IsExistingMatchingCard(c29200114.filter,tp,LOCATION_DECK,0,1,nil,true)
    else
        return Duel.IsExistingMatchingCard(c29200114.filter,tp,LOCATION_DECK,0,1,nil,false)
    end
end
function c29200114.filter(c)
    return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_PENDULUM)
end
function c29200114.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c29200114.desfilter(chkc,tp) and chkc~=e:GetHandler() end
    if chk==0 then return Duel.IsExistingTarget(c29200114.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,c29200114.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),tp)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c29200114.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
        local g=Duel.SelectMatchingCard(tp,c29200114.filter,tp,LOCATION_DECK,0,1,1,nil,false)
    local tc1=g:GetFirst()
    if tc1 then
        Duel.MoveToField(tc1,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
        local e2=Effect.CreateEffect(tc1)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CHANGE_TYPE)
        e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e2:SetCondition(c29200131.discon2)
        e2:SetReset(RESET_EVENT+0x1fc0000)
        e2:SetValue(TYPE_TRAP)
        tc1:RegisterEffect(e2)
        Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
        Duel.ConfirmCards(1-tp,tc1)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_TRIGGER)
        e1:SetReset(RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END)
        tc1:RegisterEffect(e1)
    end
    end
end

