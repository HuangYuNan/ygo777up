--7
function c20150333.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3291),7,2,c20150333.ovfilter,aux.Stringid(20150333,1))
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150333,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c20150333.descost)
	e1:SetTarget(c20150333.target)
	e1:SetOperation(c20150333.operation)
	c:RegisterEffect(e1)
end
function c20150333.ovfilter(c)
	return c:IsFaceup() and c:IsCode(20150305)
end
function c20150333.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150333.filter(c)
	return c:IsType(TYPE_EFFECT) and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemove() and c:GetCode()~=20150305
end
function c20150333.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c20150333.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150333.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c20150333.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c20150333.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then return end
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		c:CopyEffect(code,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_SET_BASE_ATTACK)
		e2:SetValue(ba)
		c:RegisterEffect(e2)
	end
end