--邪神姬·友引
function c1000111.initial_effect(c)
	c:EnableReviveLimit()
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40854197,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c1000111.descon)
	e2:SetTarget(c1000111.destg)
	e2:SetOperation(c1000111.desop)
	c:RegisterEffect(e2)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34834619,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCondition(c1000111.thcon)
	e1:SetTarget(c1000111.sptg)
	e1:SetOperation(c1000111.spop)
	c:RegisterEffect(e1)
end
function c1000111.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c1000111.filter(c)
	return c:IsDestructable()
end
function c1000111.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c1000111.filter,tp,LOCATION_ONFIELD,0,1,c) end
	local sg=Duel.GetMatchingGroup(c1000111.filter,tp,LOCATION_ONFIELD,0,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g*500)
end
function c1000111.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c1000111.filter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local g=Duel.Destroy(sg,REASON_EFFECT)
	Duel.Damage(1-tp,g*500,REASON_EFFECT)
end
function c1000111.thcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c1000111.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c1000111.spfilter(c,e,tp,m)
	return c:IsCode(1000111) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,6,1,99,c)
end
function c1000111.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c1000111.mtfilter,tp,0,LOCATION_GRAVE,e:GetHandler(),e)
		return c1000111.spfilter(e:GetHandler(),e,tp,mg)
		--return Duel.IsExistingMatchingCard(c1000111.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c1000111.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c1000111.mtfilter,tp,0,LOCATION_GRAVE,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1000111.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,6,1,99,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end
