--藏书屋·华胥的亡灵
function c6000025.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(6000025,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,6000025)
	e2:SetCost(c6000025.spcost)
	e2:SetTarget(c6000025.sptg)
	e2:SetOperation(c6000025.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6000025,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,6000025)
	e3:SetCondition(c6000025.descon)
	e3:SetTarget(c6000025.destg)
	e3:SetOperation(c6000025.desop)
	c:RegisterEffect(e3)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c6000025.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c6000025.limit)
	c:RegisterEffect(e7)
end
function c6000025.rfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x300) and (c:IsType(TYPE_RITUAL) or c:IsType(TYPE_SYNCHRO)) and c:IsAbleToGrave()
end
function c6000025.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6000025.rfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c6000025.rfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c6000025.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c6000025.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
	Duel.SpecialSummon(c,SUMMON_TYPE_RITUAL,tp,tp,true,true,POS_FACEUP)
	c:CompleteProcedure()
	end
end
function c6000025.limit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x300)
end
function c6000025.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c6000025.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsAbleToGrave() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c6000025.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end