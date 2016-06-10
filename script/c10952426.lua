--罗星 金牛座
function c10952426.initial_effect(c)
	c:EnableReviveLimit()
	c:SetSPSummonOnce(10952426)
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10952426.spcon)
	e0:SetOperation(c10952426.spop2)
	c:RegisterEffect(e0)
end
function c10952426.spfilter(c)
	return c:IsSetCard(0x233) and not c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c10952426.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x232)
end
function c10952426.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 
	and Duel.IsExistingMatchingCard(c10952426.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return Duel.IsExistingMatchingCard(c10952426.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) 
end
end
function c10952426.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10952426.spfilter,c:GetControler(),LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST) 
end