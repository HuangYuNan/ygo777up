--AST队员·机枪手
function c20150314.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c20150314.spcon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20150314,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(2)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c20150314.descost)
	e2:SetTarget(c20150314.destg)
	e2:SetOperation(c20150314.desop)
	c:RegisterEffect(e2)
end
function c20150314.spfilter1(c)
	return c:IsFaceup() and c:IsCode(20150315)
end
function c20150314.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20150314.spfilter1,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c20150314.cfilter(c)
	return c:IsDiscardable() and (c:IsSetCard(0x3291) or c:IsSetCard(0x5291) or c:IsSetCard(0x9291))
end
function c20150314.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20150314.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c20150314.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c20150314.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c20150314.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c20150314.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150314.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20150314.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20150314.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end