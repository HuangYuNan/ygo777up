--森羅の施し
function c29281570.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,29281570+EFFECT_COUNT_CODE_OATH)
    e1:SetTarget(c29281570.target)
    e1:SetOperation(c29281570.activate)
    c:RegisterEffect(e1)
end
function c29281570.filter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ) and c:IsAbleToDeck()
end
function c29281570.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c29281570.filter(chkc) end
    if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
        and Duel.IsExistingTarget(c29281570.filter,tp,LOCATION_GRAVE,0,5,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectTarget(tp,c29281570.filter,tp,LOCATION_GRAVE,0,5,5,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c29281570.activate(e,tp,eg,ep,ev,re,r,rp)
    local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=5 then return end
    Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
    local g=Duel.GetOperatedGroup()
    Duel.DisableShuffleCheck()
    local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)
    if ct==5 then
        Duel.SortDecktop(tp,tp,5)
        for i=1,5 do
            local mg=Duel.GetDecktopGroup(tp,1)
            Duel.MoveSequence(mg:GetFirst(),1)
            Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
        end
        Duel.BreakEffect()
        Duel.Draw(tp,2,REASON_EFFECT)
    end
end