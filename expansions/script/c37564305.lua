--帕拉诺尼亚 240
function c37564305.initial_effect(c)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),5,4,c37564305.ovfilter,aux.Stringid(37564305,0))
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564305,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c37564305.condition)
	e1:SetTarget(c37564305.target)
	e1:SetOperation(c37564305.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564305,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c37564305.spcost)
	e2:SetTarget(c37564305.sptg)
	e2:SetOperation(c37564305.spop)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)

--publics
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c37564305.immcon)
	e5:SetValue(c37564305.immfilter)
	c:RegisterEffect(e5)
end
function c37564305.immcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--changes
function c37564305.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x776) and c:GetAttack()==0 and c:GetDefense()==2000
end
function c37564305.immfilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner() and te:GetHandler():GetAttack()>2400
end
--effects
function c37564305.cfilter(c,e,tp)
	return c:IsFaceup() and c:GetSummonType()==SUMMON_TYPE_XYZ and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0 and c:GetAttack()>e:GetHandler():GetAttack() and c:GetOwner()==1-tp
end
function c37564305.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c37564305.cfilter,1,nil,e,tp) and not eg:IsContains(e:GetHandler()) and e:GetHandler():IsType(TYPE_XYZ)
end
function c37564305.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c37564305.cfilter,nil,e,tp)
	Duel.SetTargetCard(eg)
end
function c37564305.filter(c,e,tp)
	return c:IsFaceup() and c:GetSummonType()==SUMMON_TYPE_XYZ and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0 and c:GetAttack()>e:GetHandler():GetAttack() and c:IsRelateToEffect(e) and c:GetOwner()==1-tp
end
function c37564305.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c37564305.filter,nil,e,tp)
	local tc=g:GetFirst()
	local ov=Group.CreateGroup()
	while tc do
		if tc:GetOverlayCount()>0 then
			ov:Merge(tc:GetOverlayGroup())
		end
		local tc=g:GetNext()
	end
	if ov:GetCount()>0 then
		Duel.Overlay(c,ov)
	end
end

function c37564305.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,3,REASON_COST) and c:GetFlagEffect(37564305)==0 end
	c:RemoveOverlayCard(tp,3,3,REASON_COST)
	c:RegisterFlagEffect(37564305,RESET_CHAIN,0,1)
end
function c37564305.sfilter(c,e,tp,rk)
	return c:GetTextAttack()<e:GetHandler():GetAttack() and e:GetHandler():IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c37564305.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c37564305.sfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler():GetRank()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564305.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564305.sfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c:GetRank())
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end