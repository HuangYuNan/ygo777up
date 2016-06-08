--蓬莱人形
function c1008.initial_effect(c)
    --disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTarget(c1008.distg)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTargetRange(0,LOCATION_SZONE)
	c:RegisterEffect(e2)
	--remove
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(1008,0))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(1001)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCountLimit(1,1008)
	e5:SetTarget(c1008.target)
	e5:SetOperation(c1008.operation)
	c:RegisterEffect(e5)
end
function c1008.distg(e,c)
	local g=(4-e:GetHandler():GetSequence())
	return c:GetSequence()==g 
end
function c1008.refilter(c)
	return  c:IsAbleToRemove()
end
function c1008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c1008.refilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1008.refilter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c1008.refilter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c1008.operation(e,tp,eg,ep,ev,re,r,rp)
     if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
end