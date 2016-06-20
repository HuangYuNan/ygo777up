--凋叶棕-万花筒
function c29200113.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),4,2)
    c:EnableReviveLimit()
    --destroy
    local e8=Effect.CreateEffect(c)
    e8:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
    e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e8:SetCode(EVENT_BATTLE_DESTROYING)
    e8:SetCondition(c29200113.descon)
    e8:SetCost(c29200113.descost)
    e8:SetTarget(c29200113.destg)
    e8:SetOperation(c29200113.desop)
    c:RegisterEffect(e8)
    --tohand
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200113,0))
    e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
    e1:SetCode(EVENT_DAMAGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1,29200113)
    e1:SetCondition(c29200113.poscon)
    e1:SetTarget(c29200113.thtg)
    e1:SetOperation(c29200113.thop)
    c:RegisterEffect(e1)
end
function c29200113.poscon(e,tp,eg,ep,ev,re,r,rp)
    return ep==tp and bit.band(r,REASON_EFFECT)~=0
end
function c29200113.filter5(c)
    return c:IsSetCard(0x53e0) and c:IsLevelBelow(4) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29200113.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200113.filter5,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29200113.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29200113.filter5,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c29200113.descon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c29200113.descost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29200113.filter1(c,atk)
    return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsDestructable()
end
function c29200113.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    local atk=e:GetHandler():GetBattleTarget():GetBaseAttack()
    if chk==0 then return Duel.IsExistingMatchingCard(c29200113.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,atk) end
    local g=Duel.GetMatchingGroup(c29200113.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c29200113.desop(e,tp,eg,ep,ev,re,r,rp)
    local atk=e:GetHandler():GetBattleTarget():GetBaseAttack()
    local g=Duel.GetMatchingGroup(c29200113.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
    if g:GetCount()>0 then
        local des=Duel.Destroy(g,REASON_EFFECT)
        Duel.Damage(1-tp,des*500,REASON_EFFECT)
    end
end
