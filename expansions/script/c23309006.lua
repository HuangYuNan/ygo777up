--风之风见幽香
function c23309006.initial_effect(c)
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_DECK)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,23309006)
	e1:SetCondition(c23309006.spcon)
	e1:SetOperation(c23309006.spop)
	c:RegisterEffect(e1)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(23309006,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,13300131)
	e5:SetCost(c23309006.thcost2)
	e5:SetTarget(c23309006.thtg2)
	e5:SetOperation(c23309006.thop2)
	c:RegisterEffect(e5)
	if not YuukaGlobal then
		YuukaGlobal={}
		YuukaGlobal["Effects"]={}
	end
	YuukaGlobal["Effects"]["c23309006"]=e5
end
function c23309006.spfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsReleasable()
end
function c23309006.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c23309006.spfilter,tp,LOCATION_HAND,0,nil)
	local mg=Duel.GetMatchingGroup(c23309006.refilter,tp,LOCATION_GRAVE,0,c)
	if e:GetHandler():IsHasEffect(23309009) then g:Merge(mg) end
	if not c:IsAbleToGraveAsCost() then
		g:RemoveCard(c)
	end
	return g:CheckWithSumGreater(Card.GetLevel,8)
end
function c23309006.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c23309006.spfilter,c:GetControler(),LOCATION_HAND,0,nil)
	local mg=Duel.GetMatchingGroup(c23309006.refilter,tp,LOCATION_GRAVE,0,c)
	if e:GetHandler():IsHasEffect(23309009) then g:Merge(mg) end
	if not c:IsAbleToGraveAsCost() then
		g:RemoveCard(c)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:SelectWithSumGreater(tp,Card.GetLevel,8)
	local mg1=sg:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
	local mg2=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if mg1:GetCount()>0 then Duel.Remove(mg1,POS_FACEUP,REASON_COST) end
	if mg2:GetCount()>0 then Duel.Release(mg2,REASON_COST) end
end
function c23309006.costfilter(c,e,tp)
	return c:IsRace(RACE_PLANT) and c:IsReleasable() and (c:IsControler(tp) or c:IsFaceup())
end
function c23309006.refilter(c)
	return c:IsSetCard(0x99a) and c:IsAbleToRemoveAsCost()
end
function c23309006.thcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetMatchingGroup(c23309006.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD,nil)
	local mg2=Duel.GetMatchingGroup(c23309006.refilter,tp,LOCATION_GRAVE,0,nil)
	if e:GetHandler():IsHasEffect(23309009) then mg1:Merge(mg2) end
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)<1
		and Duel.IsExistingMatchingCard(c23309006.costfilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp)) or mg1:GetCount()>0 end
	local g=Group.CreateGroup()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=Duel.SelectMatchingCard(tp,c23309006.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil,e,tp)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=mg1:Select(tp,1,1,nil)
	end
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	else
		Duel.Release(g,REASON_COST)
	end
end
function c23309006.thfilter(c,e,tp)
	return c:IsRace(RACE_PLANT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23309006.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23309006.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c23309006.thop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c23309006.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x47e0000)
		e2:SetValue(LOCATION_DECKBOT)
		tc:RegisterEffect(e2,true)
	end
end