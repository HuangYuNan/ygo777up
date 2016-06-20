--凋叶棕-A-Yah-YAh-YaH-YAH
function c29200128.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),4,2)
    c:EnableReviveLimit()
    --
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_BATTLE_DAMAGE_TO_EFFECT)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    c:RegisterEffect(e2)
    --effect
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200128,3))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCost(c29200128.cost)
    e1:SetTarget(c29200128.target)
    e1:SetOperation(c29200128.operation)
    c:RegisterEffect(e1)
    --to hand
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(29200128,4))
    e3:SetCategory(CATEGORY_RECOVER)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCode(EVENT_DAMAGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1,29200128)
    e3:SetCondition(c29200128.thcon)
    e3:SetTarget(c29200128.thtg)
    e3:SetOperation(c29200128.thop)
    c:RegisterEffect(e3)
end
function c29200128.thcon(e,tp,eg,ep,ev,re,r,rp)
    return ep==tp and bit.band(r,REASON_EFFECT)~=0
end
function c29200128.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c29200128.thop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Recover(p,d,REASON_EFFECT)
end
function c29200128.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29200128.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
    local op=Duel.SelectOption(tp,aux.Stringid(8842266,0),aux.Stringid(8842266,1))
    e:SetLabel(op)
    if op==0 then
        e:SetCategory(CATEGORY_RECOVER)
        Duel.SetTargetPlayer(tp)
        Duel.SetTargetParam(1200)
        Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1200)
    else
        e:SetCategory(CATEGORY_DAMAGE)
        Duel.SetTargetPlayer(1-tp)
        Duel.SetTargetParam(800)
        Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
    end
end
function c29200128.operation(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    if e:GetLabel()==0 then
        Duel.Recover(p,d,REASON_EFFECT)
    else Duel.Damage(p,d,REASON_EFFECT) end
end