--森羅の施し
function c29281551.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,29281551+EFFECT_COUNT_CODE_OATH)
    e1:SetCost(c29281551.plcost)
    e1:SetTarget(c29281551.target)
    e1:SetOperation(c29281551.activate)
    c:RegisterEffect(e1)
    if not c29281551.global_check then
        c29281551.global_check=true
        local ge1=Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
        ge1:SetOperation(c29281551.checkop)
        Duel.RegisterEffect(ge1,0)
    end
end
function c29281551.checkop(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    local p1=false
    local p2=false
    while tc do
        if not tc:IsSetCard(0x3da) then
            if tc:GetSummonPlayer()==0 then p1=true else p2=true end
        end
        tc=eg:GetNext()
    end
    if p1 then Duel.RegisterFlagEffect(0,29281551,RESET_PHASE+PHASE_END,0,1) end
    if p2 then Duel.RegisterFlagEffect(1,29281551,RESET_PHASE+PHASE_END,0,1) end
end
function c29281551.counterfilter(c)
    return c:IsSetCard(0x3da)
end
function c29281551.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFlagEffect(tp,29281551)==0 end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c29281551.splimit)
    Duel.RegisterEffect(e1,tp)
end
function c29281551.splimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x3da)
end
function c29281551.filter1(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281551.sumfilter(c,e,tp)
    return c:IsSetCard(0x3da) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29281551.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
    and Duel.IsExistingMatchingCard(c29281551.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp)
    and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c29281551.activate(e,tp,eg,ep,ev,re,r,rp)
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281551.filter1,nil)
    if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c29281551.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
        Duel.MoveSequence(back:GetFirst(),1)
        Duel.BreakEffect()
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local g1=Duel.SelectMatchingCard(tp,c29281551.sumfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
        Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
        local tg=g:GetFirst()
        Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
    else
        Duel.MoveSequence(back:GetFirst(),1)
    end