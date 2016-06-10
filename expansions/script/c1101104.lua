--�ػ�Ů�� ��ķ
function c1101104.initial_effect(c)
	--spsummon1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101104,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,1101104)
	e1:SetCost(c1101104.cost1)
	e1:SetTarget(c1101104.target1)
	e1:SetOperation(c1101104.operation1)
	c:RegisterEffect(e1)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,1101104)
	e2:SetCost(c1101104.cost)
	e2:SetTarget(c1101104.sptg)
	e2:SetOperation(c1101104.spop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(1101104,ACTIVITY_SPSUMMON,c1101104.counterfilter)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c1101104.atkcon)
	e3:SetValue(1500)
	c:RegisterEffect(e3)
end
function c1101104.costfilter1(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c1101104.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.CheckReleaseGroup(tp,c1101104.costfilter1,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c1101104.costfilter1,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c1101104.filter1(c,e,tp)
	return c:IsCode(1101103) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1101104.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c1101104.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_GRAVE+LOCATION_HAND)
end
function c1101104.operation1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1101104.filter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1101104.counterfilter(c)
	return c:IsSetCard(0x1241)
end
function c1101104.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(1101104,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c1101104.splimit)
	e1:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e1,tp)
end
function c1101104.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x1241)
end
function c1101104.spfilter(c,e,tp)
	return c:IsCode(1101103) and c:IsType(TYPE_DUAL+TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c1101104.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101104.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c1101104.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1101104.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1101104.atkfilter(c)
	return c:IsCode(1101103)
end
function c1101104.atkcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c1101104.atkfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end