--凋叶棕-八咫鸟的Sky Diver
function c29200107.initial_effect(c)
    --discard deck
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(29200107,1))
    e5:SetCategory(CATEGORY_DECKDES)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e5:SetCode(EVENT_TO_GRAVE)
    e5:SetCondition(c29200107.discon)
    e5:SetTarget(c29200107.distg)
    e5:SetOperation(c29200107.disop)
    c:RegisterEffect(e5)
	--
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29200107,2))
    e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_BATTLE_DAMAGE)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCountLimit(1,29200107)
    e2:SetCondition(c29200107.thcon)
    e2:SetTarget(c29200107.thtg)
    e2:SetOperation(c29200107.thop)
    c:RegisterEffect(e2)
    --splimit
    local ea=Effect.CreateEffect(c)
    ea:SetType(EFFECT_TYPE_FIELD)
    ea:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    ea:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    ea:SetRange(LOCATION_GRAVE)
    ea:SetTargetRange(1,0)
    ea:SetCondition(c29200107.con)
    ea:SetTarget(c29200107.splimit)
    c:RegisterEffect(ea)
    local eb=ea:Clone()
    eb:SetCode(EFFECT_CANNOT_SUMMON)
    c:RegisterEffect(eb)
end
c29200107.dyz_utai_list=true
function c29200107.con(e,tp,eg,ep,ev,re,r,rp,chk)
    local tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
    return e:GetHandler()==tc
end
function c29200107.splimit(e,c)
    return not c:IsSetCard(0x53e0)
end
function c29200107.discon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation(LOCATION_DECK+LOCATION_HAND)
end
function c29200107.filter(c)
    return c.dyz_utai_list and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c29200107.distg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200107.filter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c29200107.disop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,c29200107.filter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoGrave(g,REASON_EFFECT)
    end
end
function c29200107.thcon(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst() 
    local tc1=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
    return tc:IsControler(tp) and tc:IsSetCard(0x53e0) and tc~=e:GetHandler() and e:GetHandler()==tc1
end
function c29200107.thfilter(c)
    return c.dyz_utai_list and c:IsAbleToHand()
end
function c29200107.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200107.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29200107.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29200107.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end

