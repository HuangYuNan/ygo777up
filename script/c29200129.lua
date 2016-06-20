--凋叶棕-书本的旅人
function c29200129.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),4,2)
    c:EnableReviveLimit()
	--
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_TOGRAVE)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1,29200129)
    e3:SetCost(c29200129.thcost)
    e3:SetTarget(c29200129.thtg)
    e3:SetOperation(c29200129.thop)
    c:RegisterEffect(e3)
    --avoid damage
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CHANGE_DAMAGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_AVAILABLE_BD)
    e1:SetTargetRange(1,0)
    e1:SetValue(c29200129.damval)
    c:RegisterEffect(e1)
    --damage
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29200129,1))
    e2:SetCategory(CATEGORY_RECOVER)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCode(EVENT_BATTLE_DESTROYING)
    e2:SetCondition(aux.bdcon)
    e2:SetTarget(c29200129.damtg)
    e2:SetOperation(c29200129.damop)
    c:RegisterEffect(e2)
end
function c29200129.damval(e,re,val,r,rp,rc)
    local atk=e:GetHandler():GetAttack()
    if val<=atk then return 0 else return val end
end
function c29200129.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29200129.thfilter(c)
    return c:GetLevel()>=5 and c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29200129.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200129.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29200129.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29200129.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
        Duel.BreakEffect()
        Duel.DiscardDeck(tp,1,REASON_EFFECT)
    end
end
function c29200129.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local dam=e:GetHandler():GetBattleTarget():GetAttack()
    if dam<0 then dam=0 end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(dam)
    Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,dam)
end
function c29200129.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Recover(p,d,REASON_EFFECT)
end
