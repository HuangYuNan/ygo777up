--見世物ゴブリン
function c29281450.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29281450,0))
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1,29281450)
    e2:SetCondition(c29281450.cfcon)
    e2:SetOperation(c29281450.cfop)
    c:RegisterEffect(e2)
    --tohand
    local e12=Effect.CreateEffect(c)
    e12:SetDescription(aux.Stringid(29281450,1))
    e12:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e12:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e12:SetCode(EVENT_TO_GRAVE)
    e12:SetCountLimit(1,29281451)
    e12:SetTarget(c29281450.thtg)
    e12:SetOperation(c29281450.thop)
    c:RegisterEffect(e12)
end
function c29281450.thfilter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29281450.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29281450.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29281450.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29281450.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c29281450.cfcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)~=0
end
function c29281450.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281450.cfop(e,tp,eg,ep,ev,re,r,rp)
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281450.filter1,nil)
       if g:GetCount()>0 then
          Duel.DisableShuffleCheck()
		  Duel.Draw(tp,1,REASON_EFFECT)
       else
          Duel.MoveSequence(back:GetFirst(),1)	   
       end
end