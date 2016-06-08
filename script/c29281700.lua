--森羅の施し
function c29281700.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,29281700+EFFECT_COUNT_CODE_OATH)
    e1:SetCost(c29281700.plcost)
    e1:SetTarget(c29281700.target)
    e1:SetOperation(c29281700.activate)
    c:RegisterEffect(e1)
    if not c29281700.global_check then
        c29281700.global_check=true
        local ge1=Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
        ge1:SetOperation(c29281700.checkop)
        Duel.RegisterEffect(ge1,0)
        local ge2=Effect.CreateEffect(c)
        ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge2:SetCode(EVENT_SUMMON_SUCCESS)
        ge2:SetOperation(c29281700.checkop1)
        Duel.RegisterEffect(ge2,0)
    end
end
function c29281700.checkop(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    local p1=false
    local p2=false
    while tc do
        if not tc:IsSetCard(0x3da) then
            if tc:GetSummonPlayer()==0 then p1=true else p2=true end
        end
        tc=eg:GetNext()
    end
    if p1 then Duel.RegisterFlagEffect(0,29281700,RESET_PHASE+PHASE_END,0,1) end
    if p2 then Duel.RegisterFlagEffect(1,29281700,RESET_PHASE+PHASE_END,0,1) end
end
--Limit
function c29281700.checkop1(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    local p1=false
    local p2=false
    while tc do
        if not tc:IsSetCard(0x3da) then
            if tc:GetSummonPlayer()==0 then p1=true else p2=true end
        end
        tc=eg:GetNext()
    end
    if p1 then Duel.RegisterFlagEffect(0,29281701,RESET_PHASE+PHASE_END,0,1) end
    if p2 then Duel.RegisterFlagEffect(1,29281701,RESET_PHASE+PHASE_END,0,1) end
end
function c29281700.counterfilter(c)
    return c:IsSetCard(0x3da)
end
function c29281700.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFlagEffect(tp,29281700)==0 
	and Duel.GetFlagEffect(tp,29281701)==0 end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c29281700.splimit)
    Duel.RegisterEffect(e1,tp)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_SUMMON)
    Duel.RegisterEffect(e2,tp)
end
function c29281700.splimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x3da)
end
function c29281700.filter1(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281700.sumfilter(c,e,tp)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29281700.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,2) 
    and Duel.IsExistingMatchingCard(c29281700.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
    and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c29281700.activate(e,tp,eg,ep,ev,re,r,rp)
    local back=Duel.GetDecktopGroup(tp,2)
    if not Duel.IsPlayerCanDiscardDeck(tp,2) then return end
    Duel.ConfirmDecktop(tp,2)
    local g=Duel.GetDecktopGroup(tp,2)
	local rg=g:Filter(c29281700.filter1,nil)
    if rg:GetCount()>1 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c29281700.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local g1=Duel.SelectMatchingCard(tp,c29281700.sumfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local sc=g1:GetFirst()
            if sc then
            Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
    		Duel.BreakEffect()
    		Duel.DisableShuffleCheck()
            Duel.Overlay(sc,rg)
    		end
    else
        for i=1,2 do
            local mg=Duel.GetDecktopGroup(tp,1)
            Duel.MoveSequence(mg:GetFirst(),1)
            Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
        end
    end
end