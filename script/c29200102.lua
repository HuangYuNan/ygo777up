--凋叶棕-为什么…
function c29200102.initial_effect(c)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200102,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetCondition(c29200102.condition)
    e1:SetTarget(c29200102.target)
    e1:SetOperation(c29200102.operation)
    c:RegisterEffect(e1)
    --remove
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29200102,1))
    e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e10:SetCategory(CATEGORY_REMOVE)
    e10:SetType(EFFECT_TYPE_QUICK_O)
    e10:SetRange(LOCATION_HAND)
    e10:SetCode(EVENT_FREE_CHAIN)
	e10:SetCountLimit(1,29200102)
    e10:SetCost(c29200102.rmcost)
    e10:SetTarget(c29200102.rmtg)
    e10:SetOperation(c29200102.rmop)
    c:RegisterEffect(e10)
end
function c29200102.filter5(c,code)
    return c:IsFaceup() and c:IsCode(code) and c:IsSetCard(0x53e0)
end
function c29200102.cfilter(c)
    return Duel.IsExistingMatchingCard(c29200102.filter5,tp,LOCATION_MZONE,0,1,c,c:GetCode())
end
function c29200102.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetMatchingGroupCount(c29200102.cfilter,tp,LOCATION_MZONE,0,nil)>=2
end
function c29200102.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29200102.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c29200102.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsDiscardable() end
    Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c29200102.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x53e0) and c:IsAbleToRemove()
end
function c29200102.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29200102.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29200102.filter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,c29200102.filter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c29200102.rmop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        if Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)==0 then return end
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
        e1:SetCountLimit(1)
        e1:SetLabelObject(tc)
        e1:SetCondition(c29200102.retcon)
        e1:SetOperation(c29200102.retop)
        if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
            e1:SetLabel(0)
        else
            e1:SetLabel(Duel.GetTurnCount())
        end
        Duel.RegisterEffect(e1,tp)
    end
end
function c29200102.retcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c29200102.retop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ReturnToField(e:GetLabelObject())
    e:Reset()
end

