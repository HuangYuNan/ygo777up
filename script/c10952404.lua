--悠久的使者·莎榭·弦月
function c10952404.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,c10952404.mfilter,3,4)
    c:EnableReviveLimit()
    --indes
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetValue(1)
    c:RegisterEffect(e1)
    --cannot target
    local e9=Effect.CreateEffect(c)
    e9:SetType(EFFECT_TYPE_SINGLE)
    e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
    e9:SetRange(LOCATION_MZONE)
    e9:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e9:SetValue(aux.tgoval)
    c:RegisterEffect(e9)
    --to hand
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(10952404,0))
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetCategory(CATEGORY_TOHAND)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e10:SetCondition(c10952404.thcon)
    e10:SetTarget(c10952404.target)
    e10:SetOperation(c10952404.activate)
    c:RegisterEffect(e10)
end
function c10952404.mfilter(c)
    return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and not c:IsType(TYPE_NORMAL)
end
function c10952404.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c10952404.filter(c)
    return c:IsSetCard(0x233) and c:IsAbleToHand()
end
function c10952404.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c10952404.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c10952404.filter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectTarget(tp,c10952404.filter,tp,LOCATION_GRAVE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c10952404.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SendtoHand(tc,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,tc)
    end
end