--凋叶棕-devastator
function c29200125.initial_effect(c)
    c:SetUniqueOnField(1,0,29200125)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --atk & def
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCondition(c29200125.atkcon)
    e2:SetOperation(c29200125.atkop)
    c:RegisterEffect(e2)
    --damage
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(29200125,1))
    e4:SetCategory(CATEGORY_DAMAGE)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCountLimit(1,29200125)
    e4:SetCondition(c29200125.damcon)
    e4:SetCost(c29200125.damcost)
    e4:SetTarget(c29200125.damtg)
    e4:SetOperation(c29200125.damop)
    c:RegisterEffect(e4)
end
function c29200125.damcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp
end
function c29200125.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetFlagEffect(29200125)==0 end
    e:GetHandler():RegisterFlagEffect(29200125,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c29200125.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c29200125.damop(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
end
function c29200125.filter5(c,code)
    return c:IsFaceup() and c:IsCode(code) and c:IsSetCard(0x53e0)
end
function c29200125.atkcon(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetAttacker()
    local bc=Duel.GetAttackTarget()
    if not bc then return false end
    if bc:IsControler(1-tp) then bc=tc end
    e:SetLabelObject(bc)
    return Duel.IsExistingMatchingCard(c29200125.filter5,tp,LOCATION_MZONE,0,1,bc,bc:GetCode())--bc:IsFaceup() and bc:IsSetCard(0xcd)
end
function c29200125.atkop(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
    local tc=e:GetLabelObject()
    if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetValue(tc:GetAttack()*2)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
        tc:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
        e2:SetValue(tc:GetDEFENSE()*2)
        tc:RegisterEffect(e2)
    end
end
