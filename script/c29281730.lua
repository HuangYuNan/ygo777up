--神獣王バルバロス
function c29281730.initial_effect(c)
    --summon & set with no tribute
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29281730,0))
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SUMMON_PROC)
    e1:SetCondition(c29281730.ntcon)
    e1:SetOperation(c29281730.ntop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_SET_PROC)
    c:RegisterEffect(e2)
    --token
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(29281730,1))
    e11:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
    e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e11:SetCode(29281400)
    e11:SetCountLimit(1,29281730)
    e11:SetTarget(c29281730.target)
    e11:SetOperation(c29281730.operation)
    c:RegisterEffect(e11)
    --multi attack
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29281730,2))
    e10:SetType(EFFECT_TYPE_IGNITION)
    e10:SetCountLimit(1,29281731)
    e10:SetRange(LOCATION_MZONE)
    e10:SetTarget(c29281730.target2)
    e10:SetOperation(c29281730.mtop)
    c:RegisterEffect(e10)
end
function c29281730.desfilter(c)
    return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end
function c29281730.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chkc then return chkc:IsOnField() and c29281580.desfilter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29281580.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,c29281580.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c29281730.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.Destroy(tc,REASON_EFFECT)
    end
end
function c29281730.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281730.filter2(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281730.sumfilter(c)
    return c:IsType(TYPE_MONSTER) 
end
function c29281730.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
      and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
end
function c29281730.mtop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281730.filter2,nil)
    local sg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
       if g:GetCount()>0 then
            Duel.MoveSequence(back:GetFirst(),1)
            Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,0,POS_FACEUP_DEFENSE,0)
            local tg=g:GetFirst()
            Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
        else
            Duel.MoveSequence(back:GetFirst(),1)
			Duel.ChangePosition(sg,POS_FACEUP_ATTACK,0,POS_FACEUP_ATTACK,0)
       end
end
function c29281730.ntcon(e,c,minc)
    if c==nil then return true end
    return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c29281730.ntop(e,tp,eg,ep,ev,re,r,rp,c)
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