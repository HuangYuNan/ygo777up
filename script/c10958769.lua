--翼返·天使的叹息
function c10958769.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetCondition(c10958769.condition)
    e1:SetTarget(c10958769.target)
    e1:SetOperation(c10958769.activate)
    c:RegisterEffect(e1)
end
function c10958769.cfilter(c)
    return c:IsFacedown() and c:GetSequence()<5
end
function c10958769.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c10958769.cfilter,tp,LOCATION_SZONE,0,1,nil) and tp~=Duel.GetTurnPlayer()
end
function c10958769.filter(c)
    return c:IsAbleToDeck()
end
function c10958769.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c10958769.filter,tp,0,LOCATION_SZONE,1,nil) end
    local g=Duel.GetMatchingGroup(c10958769.filter,tp,0,LOCATION_SZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c10958769.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c10958769.filter,tp,0,LOCATION_SZONE,nil)
    if g:GetCount()>0 then
        Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
    end
    Duel.NegateAttack()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(0,1)
    e1:SetCode(EFFECT_SKIP_M2)
    e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
    Duel.RegisterEffect(e1,tp)
end