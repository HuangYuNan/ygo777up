--Black Rose Apostle
function c37564019.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,37564019+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c37564019.target)
	e1:SetOperation(c37564019.activate)
	c:RegisterEffect(e1)
end
function c37564019.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x770) and c:IsDestructable() and c:IsType(TYPE_MONSTER) and Duel.IsExistingTarget(Card.IsDestructable,0,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c37564019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c37564019.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c37564019.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c37564019.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
	end
end
