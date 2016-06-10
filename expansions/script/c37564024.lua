--元素精灵·啾啾
function c37564024.initial_effect(c)
	c:EnableUnsummonable()
	--sslimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e1:SetValue(c37564024.splimit1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e3)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EFFECT_SPSUMMON_CONDITION)
	e6:SetValue(c37564024.splimit)
	c:RegisterEffect(e6)
--ss
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c37564024.hcon)
	c:RegisterEffect(e4)
--rs
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(37564024,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,37564024)
	e5:SetCost(c37564024.cost)
	e5:SetTarget(c37564024.target)
	e5:SetOperation(c37564024.operation)
	c:RegisterEffect(e5)
	Duel.AddCustomActivityCounter(37564024,ACTIVITY_SPSUMMON,c37564024.counterfilter)
end
function c37564024.counterfilter(c)
	return c:IsSetCard(0x770) or c:GetSummonLocation()~=LOCATION_EXTRA
end
function c37564024.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS)
end
function c37564024.splimit1(e,c)
	if not c then return false end
	return not c:IsSetCard(0x770)
end
function c37564024.ssfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x770)
end
function c37564024.hcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c37564024.ssfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c37564024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.GetCustomActivityCount(37564024,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c37564024.exlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c37564024.rsfilter(c,e,tp)
	return c:IsCode(37564024) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c37564024.rsfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c37564024.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>2 then ft=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564024.rsfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c37564024.exlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x770) and c:IsLocation(LOCATION_EXTRA)
end
