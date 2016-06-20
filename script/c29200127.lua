--凋叶棕-光芒
function c29200127.initial_effect(c)
    --pendulum summon
    aux.EnablePendulumAttribute(c)
    --splimit
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetRange(LOCATION_PZONE)
    e12:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e12:SetTargetRange(1,0)
    e12:SetCondition(c29200127.splimcon)
    e12:SetTarget(c29200127.splimit)
    c:RegisterEffect(e12)
    --
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_PZONE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e1:SetTarget(c29200127.target)
    e1:SetValue(500)
    c:RegisterEffect(e1)
    local e3=e1:Clone()
    e3:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e3)
    --tohand
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29200127,0))
    e10:SetCategory(CATEGORY_DAMAGE)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_BE_MATERIAL)
    e10:SetCondition(c29200127.condition)
    e10:SetTarget(c29200127.rectg)
    e10:SetOperation(c29200127.recop)
    c:RegisterEffect(e10)
    --spsummon
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(29200127,1))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e11:SetType(EFFECT_TYPE_IGNITION)
    e11:SetRange(LOCATION_HAND)
    e11:SetCountLimit(1,29200127)
    e11:SetTarget(c29200127.target1)
    e11:SetOperation(c29200127.operation1)
    c:RegisterEffect(e11)
end
function c29200127.condition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_FUSION
end
function c29200127.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,900)
end
function c29200127.recop(e,tp,eg,ep,ev,re,r,rp)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
    Duel.Damage(p,900,REASON_EFFECT)
end
function c29200127.cfilter(c,code)
    return c:IsFaceup() and c:IsCode(code)
end
function c29200127.target(e,c)
    return Duel.IsExistingMatchingCard(c29200127.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode())
end
function c29200127.splimcon(e)
    return not e:GetHandler():IsForbidden()
end
function c29200127.splimit(e,c,tp,sumtp,sumpos)
    return not c:IsSetCard(0x53e0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c29200127.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x53e0) and c:GetLevel()>=5
end
function c29200127.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29200127.filter(chkc) end
    local c=e:GetHandler()
    if chk==0 then return Duel.IsExistingTarget(c29200127.filter,tp,LOCATION_MZONE,0,1,nil)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29200127,2))
    Duel.SelectTarget(tp,c29200127.filter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c29200127.operation1(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) or tc:GetLevel()<2 then return end
    local c=e:GetHandler()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_LEVEL)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetValue(-1)
    tc:RegisterEffect(e1)
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
        local code=tc:GetCode()
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(aux.Stringid(29200109,1))
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CHANGE_CODE)
        e2:SetValue(code)
        e2:SetReset(RESET_EVENT+0xff0000)
        c:RegisterEffect(e2)
    end
end

