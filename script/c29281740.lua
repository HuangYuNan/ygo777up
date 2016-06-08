--神獣王バルバロス
function c29281740.initial_effect(c)
    --summon & set with no tribute
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281740,0))
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SUMMON_PROC)
    e1:SetCondition(c29281740.ntcon)
    e1:SetOperation(c29281740.ntop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_SET_PROC)
    c:RegisterEffect(e2)
    --multi attack
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29281740,2))
    e10:SetType(EFFECT_TYPE_IGNITION)
    e10:SetCountLimit(1,29281741)
    e10:SetRange(LOCATION_MZONE)
    e10:SetCost(c29281740.plcost)
    e10:SetTarget(c29281740.target2)
    e10:SetOperation(c29281740.mtop)
    c:RegisterEffect(e10)
    if not c29281740.global_check then
        c29281740.global_check=true
        local ge1=Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
        ge1:SetOperation(c29281740.checkop)
        Duel.RegisterEffect(ge1,0)
    end
end
function c29281740.checkop(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    local p1=false
    local p2=false
    while tc do
        if not tc:IsSetCard(0x3da) then
            if tc:GetSummonPlayer()==0 then p1=true else p2=true end
        end
        tc=eg:GetNext()
    end
    if p1 then Duel.RegisterFlagEffect(0,29281740,RESET_PHASE+PHASE_END,0,1) end
    if p2 then Duel.RegisterFlagEffect(1,29281740,RESET_PHASE+PHASE_END,0,1) end
end
function c29281740.counterfilter(c)
    return c:IsSetCard(0x3da)
end
function c29281740.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFlagEffect(tp,29281740)==0 end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c29281740.splimit)
    Duel.RegisterEffect(e1,tp)
end
function c29281740.splimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x3da)
end
function c29281740.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281740.filter2(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281740.sumfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x3da) 
end
function c29281740.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
      and Duel.IsExistingMatchingCard(c29281740.sumfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c29281740.mtop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281740.filter2,nil)
       if g:GetCount()>0 then
	        local sg=Duel.GetMatchingGroup(c29281740.sumfilter,tp,LOCATION_MZONE,0,nil) 
            Duel.MoveSequence(back:GetFirst(),1)
            local tc=sg:GetFirst()
                while tc do
                local e1=Effect.CreateEffect(e:GetHandler())
                e1:SetType(EFFECT_TYPE_SINGLE)
                e1:SetCode(EFFECT_CHANGE_LEVEL)
                e1:SetValue(6)
                e1:SetReset(RESET_EVENT+0x1fe0000)
                tc:RegisterEffect(e1)
                tc=sg:GetNext()
       end
            local tg=g:GetFirst()
            Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
       else
            Duel.MoveSequence(back:GetFirst(),1)
       end
end
function c29281740.ntcon(e,c,minc)
    if c==nil then return true end
    return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c29281740.ntop(e,tp,eg,ep,ev,re,r,rp,c)
    --change base attack
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetReset(RESET_EVENT+0xff0000)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetValue(1800)
    c:RegisterEffect(e1)
end