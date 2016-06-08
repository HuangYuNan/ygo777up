--ゴーストリック・アルカード
function c29281710.initial_effect(c)
    --xyz summon
    aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3da),6,3)
    c:EnableReviveLimit()
    --confiem
    local e12=Effect.CreateEffect(c)
    e12:SetDescription(aux.Stringid(29281710,0))
    e12:SetType(EFFECT_TYPE_IGNITION)
    e12:SetRange(LOCATION_MZONE)
    e12:SetCountLimit(1,29281710)
    e12:SetCost(c29281710.cost)
    e12:SetTarget(c29281710.target)
    e12:SetOperation(c29281710.operation)
    c:RegisterEffect(e12)
    --sort
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e13:SetCode(EVENT_TO_GRAVE)
    e13:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e13:SetCountLimit(1,29281711)
    e13:SetCondition(c29281710.sdcon)
    e13:SetTarget(c29281710.sdtg)
    e13:SetOperation(c29281710.sdop)
    c:RegisterEffect(e13)
    --copy
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(29281710,2))
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e6:SetCode(EVENT_SPSUMMON_SUCCESS)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCondition(c29281710.copycon)
    e6:SetTarget(c29281710.copytg)
    e6:SetOperation(c29281710.copyop)
    c:RegisterEffect(e6)
end
function c29281710.sdcon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():IsReason(REASON_RETURN)
end
function c29281710.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>3 end
end
function c29281710.sdop(e,tp,eg,ep,ev,re,r,rp)
    Duel.SortDecktop(tp,tp,4)
end
function c29281710.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29281710.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
end
function c29281710.filter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281710.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.ConfirmDecktop(tp,5)
    local g=Duel.GetDecktopGroup(tp,5)
    local ct=g:FilterCount(c29281710.filter,nil)
    if ct>0 then
        Duel.Damage(1-tp,800,REASON_EFFECT)
    end
	if ct>1 then
	    local sg=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		local tc=sg:GetFirst()
		if tc then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-800)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        tc:RegisterEffect(e2)
		end
	end
    if ct>2 then
        Duel.Draw(tp,1,REASON_EFFECT)
    end
    if ct>3 then
        local tg=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	    local tc=tg:GetFirst()
	    while tc do
	        if tg:GetCount()>0 then
	           Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
	           Duel.RaiseSingleEvent(tg:GetFirst(),29281400,e,0,0,0,0)
	           tc=tg:GetNext()
	        end
    	end
	end
    if ct>4 then
        local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_EXTRA,nil)
        if g:GetCount()>0 then
            local sg=g:RandomSelect(tp,1)
            Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
        end
    end
        Duel.SortDecktop(tp,tp,5)
        for i=1,5 do
            local mg=Duel.GetDecktopGroup(tp,1)
            Duel.MoveSequence(mg:GetFirst(),1)
            Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
        end
end
function c29281710.copycon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c29281710.filter5(c)
    return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c29281710.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c29281710.filter5(chkc) and chkc:IsFaceup() end
    if chk==0 then return Duel.IsExistingTarget(c29281710.filter5,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    Duel.SelectTarget(tp,c29281710.filter5,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,e:GetHandler())
end
function c29281710.copyop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local code=tc:GetOriginalCode()
        local e9=Effect.CreateEffect(c)
        e9:SetType(EFFECT_TYPE_FIELD)
        e9:SetRange(LOCATION_MZONE)
        e9:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
        e9:SetCode(EFFECT_CHANGE_CODE)
        e9:SetValue(code)
        c:RegisterEffect(e9)
    end
end