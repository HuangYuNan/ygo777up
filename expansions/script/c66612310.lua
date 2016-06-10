--扑克魔术 血色花蕾
function c66612310.initial_effect(c)
	aux.AddFusionProcFun2(c,c66612310.filter1,c66612310.filter2,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612310.sprcon)
	e1:SetOperation(c66612310.sprop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c66612310.target)
	e2:SetOperation(c66612310.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612310.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCondition(c66612310.descon)
	e5:SetTarget(c66612310.destg)
	e5:SetOperation(c66612310.desop)
	c:RegisterEffect(e5)
end
function c66612310.filter1(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612310.filter2(c)
	return (c:GetLevel()==4 or c:GetLevel()==8) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612310.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3660)
end
function c66612310.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(fc)
		and Duel.IsExistingMatchingCard(c66612310.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612310.spfilter2(c,fc)
	return (c:GetLevel()==4 or c:GetLevel()==8) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612310.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612310.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c66612310.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612310,0))
	local g1=Duel.SelectMatchingCard(tp,c66612310.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612310,1))
	local g2=Duel.SelectMatchingCard(tp,c66612310.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,nil,2,REASON_COST)
end
function c66612310.filter(c,e,tp)
	return c:IsDestructable()
end
function c66612310.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c66612310.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c66612310.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c66612310.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c66612310.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c66612310.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonLocation()==LOCATION_EXTRA 
end
function c66612310.desfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsSetCard(0x660)
end
function c66612310.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612310.desfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c66612310.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66612310.desfilter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end