--荷兰人形
function c1000.initial_effect(c)
	--destroy1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1000,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(1001)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCountLimit(1,1000)
	e1:SetCondition(c1000.condition)
	e1:SetTarget(c1000.target)
	e1:SetOperation(c1000.operation)
	c:RegisterEffect(e1)
	--destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1000,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1)
	e2:SetTarget(c1000.destg)
	e2:SetOperation(c1000.operation)
	c:RegisterEffect(e2)
end
function c1000.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsControler(tp) 
end
function c1000.dfilter(c)
	return  c:IsDestructable()
end
function c1000.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c1000.dfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1000.dfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c1000.dfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c1000.operation(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Destroy(tc,REASON_EFFECT)
end
end
function c1000.filter(c,seq)
	return c:GetSequence()==seq and c:IsDestructable()
end
function c1000.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c1000.filter(chkc,4-e:GetHandler():GetSequence()) end
	if chk==0 then return Duel.IsExistingTarget(c1000.filter,tp,0,LOCATION_ONFIELD,1,nil,4-e:GetHandler():GetSequence()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c1000.filter,tp,0,LOCATION_ONFIELD,1,1,nil,4-e:GetHandler():GetSequence())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end