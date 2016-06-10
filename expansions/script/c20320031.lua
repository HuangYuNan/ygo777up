--Subspace Tunnel
function c20320031.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20320031.target)
	e1:SetOperation(c20320031.activate)
	c:RegisterEffect(e1)
end
function c20320031.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsAbleToChangeControler()
end
function c20320031.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320031.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g1=Duel.SelectTarget(tp,c20320031.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	e:SetLabelObject(g1:GetFirst())
	local g2=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g2,1,0,0)
end
function c20320031.activate(e,tp,eg,ep,ev,re,r,rp)
	local hc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==hc then tc=g:GetNext() end
	if hc:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
	Duel.SwapControl(tc,hc,0,0)
	end
end