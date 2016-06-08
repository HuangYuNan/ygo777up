--救世魔王 鸢一折纸
function c30303055.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xabb),1,3)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39272762,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c30303055.negcon)
	e1:SetTarget(c30303055.negtg)
	e1:SetOperation(c30303055.negop)
	c:RegisterEffect(e1)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46772449,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c30303055.condition)
	e1:SetCost(c30303055.cost)
	e1:SetTarget(c30303055.destg)
	e1:SetOperation(c30303055.desop)
	c:RegisterEffect(e1)
end
function c30303055.negcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and (e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0xe01) or e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,137708) or e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,137707))
end
function c30303055.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c30303055.sfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xabb)
end
function c30303055.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c30303055.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c30303055.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c30303055.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c30303055.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)~=0  and Duel.IsExistingMatchingCard(c30303055.sfilter,tp,LOCATION_GRAVE,0,1,nil) then
	if c:IsRelateToEffect(e) and Duel.SelectYesNo(tp,aux.Stringid(30303055,0)) then
	local sc=Duel.SelectMatchingCard(tp,c30303055.sfilter,tp,LOCATION_GRAVE,0,1,2,c)
		Duel.Overlay(c,sc)
	end
	end
end
function c30303055.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
		return not ph==PHASE_DRAW or not ph==PHASE_END or not ph==PHASE_MAIN1 or not ph==PHASE_MAIN2
 or not ph==PHASE_STANDBY
end
function c30303055.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:GetFlagEffect(30303055)==0 end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
	c:RegisterFlagEffect(30303055,RESET_CHAIN,0,1)
end
function c30303055.mfilter(c)
	return c:IsDestructable()
end
function c30303055.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c30303055.mfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c30303055.mfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c30303055.mfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c30303055.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end