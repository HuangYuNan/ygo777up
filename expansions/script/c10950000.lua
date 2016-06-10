--兰
function c10950000.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetTarget(c10950000.eqtg)
	e1:SetOperation(c10950000.eqop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e2:SetCountLimit(2,10950000)
	e2:SetTarget(c10950000.target)
	e2:SetCondition(c10950000.ctcon)
	e2:SetOperation(c10950000.ctop)
	c:RegisterEffect(e2)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c10950000.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x231) and c:IsType(TYPE_MONSTER)
end
function c10950000.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c10950000.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c10950000.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c10950000.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10950000.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c10950000.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c10950000.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c10950000.cfilter(c)
	return c:IsSetCard(0x231) and c:IsType(TYPE_MONSTER) 
end
function c10950000.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10950000.cfilter,1,nil)
end
function c10950000.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0x13ac,1)
end
function c10950000.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc  and  tc:IsFaceup()  and  tc:IsRelateToEffect(e)  then
		tc:AddCounter(0x13ac,1)
	end
end