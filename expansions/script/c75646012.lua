--斯巴达四期 TANAKA
function c75646012.initial_effect(c)
		c:SetUniqueOnField(1,0,75646012)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetTarget(c75646012.destg)
	e1:SetOperation(c75646012.desop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c75646012.infilter)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c75646012.infilter(e,c)
	return bit.band(c:GetType(),0x20002)==0x20002 and c:GetCode()~=75646012
end
function c75646012.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c1) and c:IsDestructable()
		and Duel.IsExistingTarget(Card.IsDestructable,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function c75646012.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c75646012.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c75646012.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c75646012.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end