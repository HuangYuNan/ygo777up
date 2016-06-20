--凋叶棕-月光照耀下的连环杀人鬼
function c29200101.initial_effect(c)
    --pendulum summon
    aux.EnablePendulumAttribute(c)
    --scale change
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200101,0))
    e1:SetCategory(CATEGORY_DICE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1)
    e1:SetTarget(c29200101.sctg)
    e1:SetOperation(c29200101.scop)
    c:RegisterEffect(e1)
	--splimit
    local ed=Effect.CreateEffect(c)
    ed:SetType(EFFECT_TYPE_FIELD)
    ed:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    ed:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    ed:SetRange(LOCATION_PZONE)
    ed:SetTargetRange(1,0)
    ed:SetTarget(c29200101.splimit)
    c:RegisterEffect(ed)
    --tuner
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29200101,0))
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCountLimit(1,29200101)
    e1:SetTarget(c29200101.target)
    e1:SetOperation(c29200101.operation)
    c:RegisterEffect(e1)
end
function c29200101.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x53e0) and not c:IsType(TYPE_TUNER)
end
function c29200101.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29200101.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c29200101.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    Duel.SelectTarget(tp,c29200101.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c29200101.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetCode(EFFECT_ADD_TYPE)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        e1:SetValue(TYPE_TUNER)
        tc:RegisterEffect(e1)
    end
end
function c29200101.splimit(e,c,tp,sumtp,sumpos)
    local seq=e:GetHandler():GetSequence()
    local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
    if tc and not tc:IsSetCard(0x53e0) then
        return true
    else
        return false
    end
end
function c29200101.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetLeftScale()<10 end
    Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c29200101.scop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not e:GetHandler():IsRelateToEffect(e) then return end
	local d1,d2=Duel.TossDice(tp,2)
	local sch=d1+d2
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_LSCALE)
    e1:SetValue(sch)
    e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CHANGE_RSCALE)
    c:RegisterEffect(e2)
end
