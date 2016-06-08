--シューティング・スター・ドラゴン
function c29281420.initial_effect(c)
    --multi attack
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281420,2))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCountLimit(1)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c29281420.mtcon)
    e1:SetOperation(c29281420.mtop)
    c:RegisterEffect(e1)
    --search
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29281420,0))
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetCode(EVENT_BATTLE_DESTROYED)
    e10:SetCondition(c29281420.condition)
    e10:SetTarget(c29281420.target)
    e10:SetOperation(c29281420.operation)
    c:RegisterEffect(e10)
end
function c29281420.condition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c29281420.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281420.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29281420.filter1,tp,LOCATION_DECK,0,1,nil) end
end
function c29281420.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29281420,1))
    local g=Duel.SelectMatchingCard(tp,c29281420.filter1,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.ShuffleDeck(tp)
        Duel.MoveSequence(g:GetFirst(),0)
        Duel.ConfirmDecktop(tp,1)
    end
end
function c29281420.mtcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5
end
function c29281420.filter(c)
    return c:IsSetCard(0x3da)
end
function c29281420.mtop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ConfirmDecktop(tp,5)
    local g=Duel.GetDecktopGroup(tp,5)
    local ct=g:FilterCount(c29281420.filter,nil)
    Duel.ShuffleDeck(tp)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(ct*300)
        e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
        e:GetHandler():RegisterEffect(e1)
end