--秋之花 风见幽香
function c23309002.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23309002,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23309002)
	e1:SetCost(c23309002.cost)
	e1:SetTarget(c23309002.target)
	e1:SetOperation(c23309002.operation)
	c:RegisterEffect(e1)
	--tohand
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(23309002,1))
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_RELEASE)
	e8:SetCountLimit(1,23309002)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e8:SetTarget(c23309002.thtg)
	e8:SetOperation(c23309002.thop)
	c:RegisterEffect(e8)
	if not YuukaGlobal then
		YuukaGlobal={}
		YuukaGlobal["Effects"]={}
	end
	YuukaGlobal["Effects"]["c23309002"]=e8
end
function c23309002.costfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsReleasable()
end
function c23309002.refilter(c)
	return c:IsSetCard(0x99a) and c:IsAbleToRemoveAsCost()
end
function c23309002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetMatchingGroup(c23309002.costfilter,tp,LOCATION_MZONE,0,nil)
	local mg2=Duel.GetMatchingGroup(c23309002.refilter,tp,LOCATION_GRAVE,0,nil)
	if e:GetHandler():IsHasEffect(23309009) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then mg1:Merge(mg2) end
	if chk==0 then return mg1:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=mg1:Select(tp,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	else
		Duel.Release(g,REASON_COST)
	end
end
function c23309002.spfilter(c,e,tp)
	return c:IsCode(23309006) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c23309002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23309002.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23309002.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstMatchingCard(c23309002.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3,true)
	end
end
function c23309002.filter(c,e,tp)
	return c:IsRace(RACE_PLANT) and not c:IsCode(23309002) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23309002.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c23309002.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c23309002.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c23309002.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c23309002.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
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
