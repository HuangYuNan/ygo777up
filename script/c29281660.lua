--ゴーストリック・アルカード
function c29281660.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3da),4,2)
    c:EnableReviveLimit()
    --confiem
    local e12=Effect.CreateEffect(c)
    e12:SetDescription(aux.Stringid(29281660,0))
    e12:SetType(EFFECT_TYPE_QUICK_O)
    e12:SetCode(EVENT_FREE_CHAIN)
    e12:SetRange(LOCATION_MZONE)
    e12:SetCountLimit(1,29281660)
    e12:SetCost(c29281660.cost)
    e12:SetTarget(c29281660.target)
    e12:SetOperation(c29281660.operation)
    c:RegisterEffect(e12)
    --sort
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e13:SetCode(EVENT_TO_GRAVE)
    e13:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e13:SetCountLimit(1,29281661)
    e13:SetCondition(c29281660.sdcon)
    e13:SetTarget(c29281660.sdtg)
    e13:SetOperation(c29281660.sdop)
    c:RegisterEffect(e13)
    --must attack
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_MUST_ATTACK)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(0,LOCATION_MZONE)
    c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_CANNOT_EP)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetTargetRange(0,1)
    e3:SetCondition(c29281660.becon)
    c:RegisterEffect(e3)
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e5:SetCode(EFFECT_MUST_BE_ATTACKED)
    e5:SetRange(LOCATION_MZONE)
    c:RegisterEffect(e5)
end
function c29281660.becon(e)
    return Duel.IsExistingMatchingCard(Card.IsAttackable,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c29281660.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29281660.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
end
function c29281660.filter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281660.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.ConfirmDecktop(tp,5)
    local g=Duel.GetDecktopGroup(tp,5)
    local ct=g:FilterCount(c29281620.filter,nil)
    if ct>0 then
    --double
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
    e4:SetCondition(c29281660.damcon)
    e4:SetOperation(c29281660.damop)
    e:GetHandler():RegisterEffect(e4)
    end
    if ct>2 then
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e2:SetValue(1)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e2)
    end
    if ct>4 then
    --immune
    local e3=Effect.CreateEffect(e:GetHandler())
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_IMMUNE_EFFECT)
    e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
    e3:SetValue(c29281660.efilter)
    e:GetHandler():RegisterEffect(e3)
    end
        Duel.SortDecktop(tp,tp,5)
        for i=1,5 do
            local mg=Duel.GetDecktopGroup(tp,1)
            Duel.MoveSequence(mg:GetFirst(),1)
            Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
        end
end
function c29281660.sdcon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():IsReason(REASON_RETURN)
end
function c29281660.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c29281660.sdop(e,tp,eg,ep,ev,re,r,rp)
    Duel.SortDecktop(tp,tp,3)
end
function c29281660.damcon(e,tp,eg,ep,ev,re,r,rp)
    return ep~=tp and e:GetHandler():GetBattleTarget()~=nil
end
function c29281660.damop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ChangeBattleDamage(ep,ev*2)
end
function c29281660.efilter(e,te)
    return te:GetOwner()~=e:GetOwner()
end