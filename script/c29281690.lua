--星見獣ガリス
function c29281690.initial_effect(c)
    --special summon
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(29281690,0))
    e11:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE+CATEGORY_DECKDES)
    e11:SetType(EFFECT_TYPE_IGNITION)
    e11:SetRange(LOCATION_HAND)
    e11:SetCost(c29281690.spcost)
    e11:SetTarget(c29281690.sptarget)
    e11:SetOperation(c29281690.spoperation)
    c:RegisterEffect(e11)
    --multi attack
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281690,2))
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
    e1:SetCountLimit(1)
    e1:SetCondition(c29281690.atkcon)
    e1:SetTarget(c29281690.target2)
    e1:SetOperation(c29281690.mtop)
    c:RegisterEffect(e1)
end
function c29281690.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not e:GetHandler():IsPublic() end
end
function c29281690.sptarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c29281690.filter1(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281690.spoperation(e,tp,eg,ep,ev,re,r,rp,c)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1)
    local tc=g:GetFirst()
    if tc then
        Duel.MoveSequence(back:GetFirst(),1)
        if tc:IsType(TYPE_MONSTER) and tc:IsSetCard(0x3da) then
               if c:IsRelateToEffect(e) then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
           else
               if c:IsRelateToEffect(e) then Duel.Destroy(c,REASON_EFFECT) end
        end
        Duel.RaiseSingleEvent(back:GetFirst(),29281400,e,0,0,0,0)
    end
end
function c29281690.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c29281690.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281690.mtop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281690.filter1,nil)
       if g:GetCount()>0 then
	      Duel.MoveSequence(back:GetFirst(),1)
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_FIELD)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetTargetRange(LOCATION_MZONE,0)
            e1:SetTarget(c29281690.atktg)
            e1:SetValue(500)
            e1:SetReset(RESET_PHASE+RESET_END)
            Duel.RegisterEffect(e1,tp)
            local e2=e1:Clone()
            e2:SetCode(EFFECT_UPDATE_DEFENSE)
            Duel.RegisterEffect(e2,tp)
           local tg=g:GetFirst()
           Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
        else
            Duel.MoveSequence(back:GetFirst(),1)
        end
end
function c29281690.atktg(e,c)
    return c:IsSetCard(0x3da)
end