--罗星姬 射手座
function c10952418.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10952418.spcon)
	e0:SetOperation(c10952418.spop2)
	c:RegisterEffect(e0)
	--disable field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(c10952418.disop)
	c:RegisterEffect(e1)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10952418.discon)
	e3:SetCountLimit(1)
	e3:SetTarget(c10952418.distg)
	e3:SetOperation(c10952418.disop2)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e4)
end
function c10952418.spfilter(c)
	return c:IsSetCard(0x233) and c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c10952418.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x232)
end
function c10952418.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 
	and Duel.IsExistingMatchingCard(c10952418.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return Duel.IsExistingMatchingCard(c10952418.spfilter,c:GetControler(),LOCATION_MZONE,0,3,nil) 
end
end
function c10952418.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10952418.spfilter,c:GetControler(),LOCATION_MZONE,0,3,3,nil)
	Duel.SendtoGrave(g,REASON_COST) 
end
function c10952418.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringid(10952418,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=bit.bor(dis1,dis2)
	end
	return dis1
end
function c10952418.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c10952418.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10952418.disop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end