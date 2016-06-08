--シューティング・スター・ドラゴン
function c29281600.initial_effect(c)
    --multi attack
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281600,2))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCountLimit(1)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTarget(c29281600.target2)
    e1:SetOperation(c29281600.mtop)
    c:RegisterEffect(e1)
    --pos
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29281600,0))
    e2:SetCategory(CATEGORY_POSITION)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    e2:SetTarget(c29281600.target1)
    e2:SetOperation(c29281600.operation1)
    c:RegisterEffect(e2)
    --search
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29281600,1))
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetCode(EVENT_BATTLE_DESTROYED)
    e10:SetCondition(c29281600.condition)
    e10:SetTarget(c29281600.target)
    e10:SetOperation(c29281600.operation)
    c:RegisterEffect(e10)
end
function c29281600.condition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c29281600.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281600.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29281600.filter1,tp,LOCATION_DECK,0,1,nil) end
end
function c29281600.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29281600,1))
    local g=Duel.SelectMatchingCard(tp,c29281600.filter1,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.ShuffleDeck(tp)
        Duel.MoveSequence(g:GetFirst(),0)
        Duel.ConfirmDecktop(tp,1)
    end
end
function c29281600.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAttackPos() end
    Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c29281600.operation1(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
        Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
    end
end
function c29281600.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281600.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281600.mtop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281480.filter1,nil)
    if g:GetCount()>0 then
        Duel.MoveSequence(back:GetFirst(),1)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DIRECT_ATTACK)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e1)
	    local tg=g:GetFirst()
        Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
    else
        Duel.MoveSequence(back:GetFirst(),1)
    end
end