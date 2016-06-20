--凋叶棕-悠久的摇篮曲
function c29200124.initial_effect(c)
    --atkdef 0
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200124,0))
    e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c29200124.condition)
    e1:SetCost(c29200124.cost)
    e1:SetOperation(c29200124.operation)
    c:RegisterEffect(e1)
    --todeck
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCountLimit(1)
    e2:SetTarget(c29200124.tdtg)
    e2:SetOperation(c29200124.tdop)
    c:RegisterEffect(e2)
end
function c29200124.condition(e,tp,eg,ep,ev,re,r,rp)
    local a=Duel.GetAttacker()
    local d=Duel.GetAttackTarget()
    if not d then return false end
    if a:IsControler(1-tp) then a,d=d,a end
    return a:IsSetCard(0x53e0) and a:IsRelateToBattle() and (d:GetAttack()>0 or d:GetDefence()>0)
end
function c29200124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
    Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c29200124.operation(e,tp,eg,ep,ev,re,r,rp)
    local a=Duel.GetAttacker()
    local d=Duel.GetAttackTarget()
    if a:IsControler(1-tp) then d=a end
    if not d:IsRelateToBattle() or d:IsFacedown() then return end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_ATTACK_FINAL)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e1:SetValue(0)
    d:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
    d:RegisterEffect(e2)
end
function c29200124.thfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x53e0) and c:IsAbleToHand()
end
function c29200124.tdfilter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end
function c29200124.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29200124.thfilter(chkc) and chkc~=e:GetHandler() end
    if chk==0 then return Duel.IsExistingTarget(c29200124.thfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
        and Duel.IsExistingMatchingCard(c29200124.tdfilter,tp,0,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectTarget(tp,c29200124.thfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_ONFIELD)
end
function c29200124.tdop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
        local g=Duel.SelectMatchingCard(tp,c29200124.tdfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
        Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
    end
end


