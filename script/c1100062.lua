--天流「天水奇迹」
function c1100062.initial_effect(c)
	c:SetUniqueOnField(1,0,1100062)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c1100062.target1)
	e1:SetOperation(c1100062.operation)
	c:RegisterEffect(e1)
	--instant
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c1100062.cost2)
	e2:SetTarget(c1100062.target2)
	e2:SetOperation(c1100062.operation)
	c:RegisterEffect(e2)
	--Synchro Summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c1100062.syncost)
	e2:SetTarget(c1100062.syntg)
	e2:SetOperation(c1100062.synop)
	c:RegisterEffect(e2)
end
function c1100062.filter1(c,e,tp)
	return c:IsSetCard(0x5240) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1100062.filter2(c)
	return c:IsSetCard(0x5240) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetCode()~=1100062 and c:IsAbleToHand()
end
function c1100062.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100062.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
	local b2=Duel.IsExistingMatchingCard(c1100062.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
	local op=2
	e:SetCategory(0)
	if Duel.GetFlagEffect(tp,1100062)==0 and (b1 or b2) and Duel.SelectYesNo(tp,aux.Stringid(1100062,0)) then
		if b1 and b2 then
			op=Duel.SelectOption(tp,aux.Stringid(1100062,1),aux.Stringid(1100062,2))
		elseif b1 then
			op=Duel.SelectOption(tp,aux.Stringid(1100062,1))
		else
			op=Duel.SelectOption(tp,aux.Stringid(1100062,2))+1
		end
		if op==0 then
			e:SetCategory(CATEGORY_SPECIAL_SUMMON)
			Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
		else
			e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
			Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
		end
		Duel.RegisterFlagEffect(tp,1100062,RESET_PHASE+PHASE_END,0,1)
	end
	e:SetLabel(op)
end
function c1100062.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==2 or not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c1100062.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c1100062.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c1100062.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,1100062)==0 end
	Duel.RegisterFlagEffect(tp,1100062,RESET_PHASE+PHASE_END,0,1)
end
function c1100062.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100062.filter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
	local b2=Duel.IsExistingMatchingCard(c1100062.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(1100062,1),aux.Stringid(1100062,2))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(1100062,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(1100062,2))+1
	end
	e:SetLabel(op)
	if op==0 then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
	else
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	end
end
function c1100062.syncost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1100062.mfilter(c)
	return c:IsSetCard(0x5240) and c:IsType(TYPE_TUNER)
end
function c1100062.cfilter(c,syn)
	return syn:IsSynchroSummonable(c) and syn:IsAttribute(ATTRIBUTE_DEVINE)
end
function c1100062.spfilter(c,mg)
	return mg:IsExists(c1100062.cfilter,1,nil,c)
end
function c1100062.syntg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c1100062.mfilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c1100062.spfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c1100062.synop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c1100062.mfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c1100062.spfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tg=mg:FilterSelect(tp,c1100062.cfilter,1,1,nil,sg:GetFirst())
		Duel.SynchroSummon(tp,sg:GetFirst(),tg:GetFirst())
	end
end