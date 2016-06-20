--凋叶棕-永恒不变之物
function c29200126.initial_effect(c)
    --pendulum summon
    aux.EnablePendulumAttribute(c)
    --splimit
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetRange(LOCATION_PZONE)
    e12:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e12:SetTargetRange(1,0)
    e12:SetCondition(c29200126.splimcon)
    e12:SetTarget(c29200126.splimit)
    c:RegisterEffect(e12)
    --
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_PZONE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e1:SetTarget(c29200126.target)
    e1:SetValue(500)
    c:RegisterEffect(e1)
    local e3=e1:Clone()
    e3:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e3)
    --tohand
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29200126,2))
    e10:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_BE_MATERIAL)
    e10:SetCondition(c29200126.condition)
    e10:SetTarget(c29200126.rectg)
    e10:SetOperation(c29200126.recop)
    c:RegisterEffect(e10)
    --cos
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200126,0))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCountLimit(1)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCost(c29200126.coscost)
    e1:SetOperation(c29200126.cosoperation)
    c:RegisterEffect(e1)
end
function c29200126.condition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_FUSION
end
function c29200126.filter(c,e,tp)
    return c:IsFaceup() and Duel.IsPlayerCanSpecialSummonMonster(tp,29200022,0x53e0,0x4011,1500,1500,3,RACE_PSYCHO,ATTRIBUTE_DARK)
end
function c29200126.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and c29200126.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c29200126.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local g=Duel.SelectTarget(tp,c29200126.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c29200126.recop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local tc=Duel.GetFirstTarget()
    if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
    if not Duel.IsPlayerCanSpecialSummonMonster(tp,29200022,0x53e0,0x4011,1500,1500,3,RACE_PSYCHO,ATTRIBUTE_DARK) then return end
    local token=Duel.CreateToken(tp,29200022)
    Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CHANGE_CODE)
        e2:SetValue(tc:GetCode())
        e2:SetReset(RESET_EVENT+0xff0000)
        token:RegisterEffect(e2)
    Duel.SpecialSummonComplete()
end
function c29200126.cfilter(c,code)
    return c:IsFaceup() and c:IsCode(code)
end
function c29200126.target(e,c)
    return Duel.IsExistingMatchingCard(c29200126.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode())
end
function c29200126.splimcon(e)
    return not e:GetHandler():IsForbidden()
end
function c29200126.splimit(e,c,tp,sumtp,sumpos)
    return not c:IsSetCard(0x53e0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c29200126.filter2(c,fc)
    if not c:IsAbleToGraveAsCost() then return false end
    return c:IsCode(table.unpack(fc.material))
end
function c29200126.filter1(c,tp)
    return c.material and c:IsSetCard(0x53e0) and Duel.IsExistingMatchingCard(c29200126.filter2,tp,LOCATION_DECK,0,1,nil,c)
end
function c29200126.coscost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200126.filter1,tp,LOCATION_EXTRA,0,1,nil,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local g=Duel.SelectMatchingCard(tp,c29200126.filter1,tp,LOCATION_EXTRA,0,1,1,nil,tp)
    Duel.ConfirmCards(1-tp,g)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local cg=Duel.SelectMatchingCard(tp,c29200126.filter2,tp,LOCATION_DECK,0,1,1,nil,g:GetFirst())
    Duel.SendtoGrave(cg,REASON_COST)
    e:SetLabel(cg:GetFirst():GetCode())
end
function c29200126.cosoperation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_CODE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e1:SetValue(e:GetLabel())
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29200126,1))
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e2:SetCountLimit(1)
    e2:SetRange(LOCATION_MZONE)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e2:SetLabelObject(e1)
    e2:SetOperation(c29200126.rstop)
    c:RegisterEffect(e2)
end
function c29200126.rstop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local e1=e:GetLabelObject()
    e1:Reset()
    Duel.HintSelection(Group.FromCards(c))
    Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end

