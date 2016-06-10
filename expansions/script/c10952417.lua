--罗星 山猫座
function c10952417.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10952417.spcon)
	e0:SetOperation(c10952417.spop2)
	c:RegisterEffect(e0)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10952417,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c10952417.spcon2)
	e3:SetTarget(c10952417.sptg)
	e3:SetOperation(c10952417.spop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e4)
	--extra summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetOperation(c10952417.sumop)
	c:RegisterEffect(e6)
end
function c10952417.spfilter(c)
	return c:IsSetCard(0x233) and not c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c10952417.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x232)
end
function c10952417.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 
	and Duel.IsExistingMatchingCard(c10952417.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return Duel.IsExistingMatchingCard(c10952417.spfilter,c:GetControler(),LOCATION_MZONE,0,3,nil) 
end
end
function c10952417.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10952417.spfilter,c:GetControler(),LOCATION_MZONE,0,3,3,nil)
	Duel.SendtoGrave(g,REASON_COST) 
end
function c10952417.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10952417.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10952417.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10952417.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10952417.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10952417.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,10952417)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,10952417,RESET_PHASE+PHASE_END,0,1)
end
function c10952417.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end