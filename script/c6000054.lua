--高等东方术
function c6000054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,6000054)
	e1:SetTarget(c6000054.target)
	e1:SetOperation(c6000054.activate)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(6000054,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,6000054)
	e2:SetCost(c6000054.cost)
	e2:SetTarget(c6000054.sptg)
	e2:SetOperation(c6000054.spop)
	c:RegisterEffect(e2)
end
function c6000054.lr(c)
	local lv=0
	if c:GetLevel()>0 then lv=c:GetLevel() end
	if c:GetRank()>0 then lv=c:GetRank() end
	return lv
end
function c6000054.mfilter(c,e,slv)
	return c:IsFaceup() and c:IsSetCard(0x300) and not c:IsImmuneToEffect(e) and not c:IsType(TYPE_XYZ) and c:IsReleasable()
	and c6000054.lr(c)<=slv-3
end
function c6000054.sfilter(c,e,tp)
	return c:IsSetCard(0x300)
	and bit.band(c:GetType(),0x81)==0x81 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
	and ((Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c6000054.mfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,c:GetLevel()))
	or (Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and Duel.IsExistingMatchingCard(c6000054.mfilter,tp,LOCATION_MZONE,0,1,nil,e,c:GetLevel())))
end
function c6000054.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6000054.sfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c6000054.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c6000054.sfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c6000054.sfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat=Group.CreateGroup()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			mat=Duel.SelectMatchingCard(tp,c6000054.mfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tc:GetLevel())
		else 
			mat=Duel.SelectMatchingCard(tp,c6000054.mfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tc:GetLevel()) 
		end
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-1000)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function c6000054.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6000054.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsType(TYPE_RITUAL) and c:IsSetCard(0x300)
end
function c6000054.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c6000054.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c6000054.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c6000054.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end