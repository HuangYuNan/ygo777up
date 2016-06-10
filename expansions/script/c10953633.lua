--泰瑞丝缇娜·木原·莱夫雷恩
function c10953633.initial_effect(c)
	c:SetUniqueOnField(1,0,10953633)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(c10953633.fsfilter),3,true)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10953633,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c10953633.target)
	e1:SetOperation(c10953633.activate)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(-1)
	c:RegisterEffect(e2)
	--battle indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetValue(c10953633.valcon)
	c:RegisterEffect(e3)
	--battle indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCountLimit(2)
	e4:SetValue(c10953633.valcon2)
	c:RegisterEffect(e4)
	--special summon rule
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_SPSUMMON_PROC)
	e10:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e10:SetRange(LOCATION_EXTRA)
	e10:SetCondition(c10953633.sprcon)
	e10:SetOperation(c10953633.sprop)
	c:RegisterEffect(e10)
end
function c10953633.fsfilter(c)
	return c:IsSetCard(0x23c) and c:IsType(TYPE_MONSTER)
end
function c10953633.spfilter1(c,e)
	return  c:IsSetCard(0x23c) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(e,true)
end
function c10953633.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c10953633.spfilter1,tp,LOCATION_MZONE,0,3,nil,c)
end
function c10953633.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectMatchingCard(tp,c10953633.spfilter1,tp,LOCATION_MZONE,0,3,3,nil,e:GetHandler())
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c10953633.filter(c)
	return c:IsSetCard(0x23c) and c:IsAbleToRemove()
end
function c10953633.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingTarget(c10953633.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,c10953633.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local rm=g1:GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rm,1,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	local ds=g2:GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ds,1,0,0)
end
function c10953633.activate(e,tp,eg,ep,ev,re,r,rp)
	local ex1,g1=Duel.GetOperationInfo(0,CATEGORY_REMOVE)
	local rm=g1:GetFirst()
	if not rm:IsRelateToEffect(e) then return end
	if Duel.Remove(rm,POS_FACEUP,REASON_EFFECT)==0 then return end
	local ex2,g2=Duel.GetOperationInfo(0,CATEGORY_DESTROY)
	local ds=g2:GetFirst()
	if not ds:IsRelateToEffect(e) then return end
	Duel.Destroy(ds,REASON_EFFECT)
end
function c10953633.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c10953633.valcon2(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
