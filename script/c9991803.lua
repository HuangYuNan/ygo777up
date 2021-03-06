--Necrotic Sliver
require "expansions/script/c9990000"
function c9991803.initial_effect(c)
	Dazz.SliverCommonEffect(c,3,9991803)
end
c9991803.Dazz_name_sliver=true
function c9991803.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991803,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c9991803.cost)
	e1:SetTarget(c9991803.target)
	e1:SetOperation(c9991803.operation)
	c:RegisterEffect(e1)
end
function c9991803.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and Duel.IsExistingMatchingCard(Card.IsReleasable,tp,LOCATION_ONFIELD,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,LOCATION_ONFIELD,0,1,1,c)
	g:AddCard(c)
	Duel.Release(g,REASON_COST)
end
function c9991803.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() and chkc:IsControler(1-tp) end
	if chk==0 then return e:GetHandler():IsHasEffect(9991803) and Duel.GetFlagEffect(tp,9991803)<2
		and Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.RegisterFlagEffect(tp,9991803,RESET_PHASE+PHASE_END,0,1)
end
function c9991803.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:GetControler()==1-tp then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end