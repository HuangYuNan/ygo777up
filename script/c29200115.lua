--凋叶棕-哎呀到此为止了
function c29200115.initial_effect(c)
    --destroy and set
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1,29200115)
    e1:SetTarget(c29200115.target)
    e1:SetOperation(c29200115.operation)
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
    local e10=Effect.CreateEffect(c)
    e10:SetCategory(CATEGORY_DESTROY)
    e10:SetType(EFFECT_TYPE_ACTIVATE)
    e10:SetProperty(0,EFFECT_FLAG2_COF+EFFECT_FLAG_CARD_TARGET)
    e10:SetCode(EVENT_FREE_CHAIN)
    e10:SetCost(c29200115.cost5)
    e10:SetTarget(c29200115.target5)
    e10:SetOperation(c29200115.activate5)
    c:RegisterEffect(e10)
end
function c29200115.filter1(c,tp)
    return c:IsDiscardable() and ((c29200115.filter2(c) and c:IsAbleToGraveAsCost())
        or Duel.IsExistingMatchingCard(c29200115.filter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,c))
end
function c29200115.filter2(c)
    return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_PENDULUM)
end
function c29200115.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200115.filter1,tp,LOCATION_HAND,0,1,nil,tp) end
    Duel.DiscardHand(tp,c29200115.filter1,1,1,REASON_COST+REASON_DISCARD,nil,tp)
end
function c29200115.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
    local g=Duel.SelectMatchingCard(tp,c29200115.filter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
    local tc=g:GetFirst()
    if tc then
        Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
        Duel.ConfirmCards(1-tp,tc)
        local e2=Effect.CreateEffect(tc)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CHANGE_TYPE)
        e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e2:SetCondition(c29200131.discon2)
        e2:SetReset(RESET_EVENT+0x1fc0000)
        e2:SetValue(TYPE_TRAP)
        tc:RegisterEffect(e2)
        Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_TRIGGER)
        e1:SetReset(RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
    end
end
function c29200115.filter(c,ec)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
        and Duel.IsExistingTarget(c29200115.tgfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ec,c)
end
function c29200115.tgfilter(c,tc)
    return c:IsDestructable() and c~=tc
end
function c29200115.cost5(e,tp,eg,ep,ev,re,r,rp,chk)
    e:SetLabel(1)
    return true
end
function c29200115.target5(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local c=e:GetHandler()
    if chkc then return chkc:IsOnField() and chkc:IsDestructable() and chkc~=c end
    if chk==0 then
        if e:GetLabel()~=0 then
            e:SetLabel(0)
            return Duel.IsExistingMatchingCard(c29200115.filter,tp,LOCATION_ONFIELD,0,1,c,c)
        else
            return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
        end
    end
    if e:GetLabel()~=0 then
        e:SetLabel(0)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
        local g=Duel.SelectMatchingCard(tp,c29200115.filter,tp,LOCATION_ONFIELD,0,1,1,c,c)
        Duel.SendtoGrave(g,REASON_COST)
    end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c29200115.activate5(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.Destroy(tc,REASON_EFFECT)
    end
end



