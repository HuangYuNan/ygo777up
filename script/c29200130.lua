--凋叶棕-Demon Strundum
function c29200130.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),aux.NonTuner(Card.IsSetCard,0x53e0),1)
    c:EnableReviveLimit()
    --damage
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200130,0))
    e1:SetCategory(CATEGORY_DAMAGE)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_BATTLE_DESTROYING)
    e1:SetCondition(c29200130.damcon)
    e1:SetTarget(c29200130.damtg)
    e1:SetOperation(c29200130.damop)
    c:RegisterEffect(e1)
    --replace
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EFFECT_DESTROY_REPLACE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c29200130.adcon)
    e2:SetTarget(c29200130.indtg)
    e2:SetValue(c29200130.indval)
    c:RegisterEffect(e2)
end
function c29200130.adcon(e)
    local tp=e:GetHandlerPlayer()
    return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c29200130.indfilter(c,tp)
    return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsReason(REASON_EFFECT)
        and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x53e0)
end
function c29200130.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return eg:IsExists(c29200130.indfilter,1,nil,tp) end
    return true
end
function c29200130.indval(e,c)
    return c29200130.indfilter(c,e:GetHandlerPlayer())
end
function c29200130.damcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c29200130.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(ct*100)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*100)
end
function c29200130.damop(e,tp,eg,ep,ev,re,r,rp)
    local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
    Duel.Damage(p,ct*100,REASON_EFFECT)
end

