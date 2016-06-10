--SAO•西莉卡
function c20152614.initial_effect(c)
	c:SetUniqueOnField(1,1,20152614)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152614.ovfilter,aux.Stringid(20152614,7),3,nil)
	c:EnableReviveLimit()
		--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c20152614.sptg)
	e1:SetOperation(c20152614.spop)
	c:RegisterEffect(e1)
		--Atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20152614.condition)
	e2:SetTarget(c20152614.adtg)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(2400)
	c:RegisterEffect(e2)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152614,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c20152614.cost)
	e4:SetTarget(c20152614.target)
	e4:SetOperation(c20152614.operation)
	c:RegisterEffect(e4)
end
function c20152614.ovfilter(c)
	return c:IsCode(20152606) and c:IsFaceup()
end
	function c20152614.filter(c,e,tp)
	return c:IsCode(20152609) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c20152614.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c20152614.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
	Duel.SetChainLimit(aux.FALSE)
end
function c20152614.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152614.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c20152614.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152606)
end
function c20152614.adtg(e,c)
	return c:IsCode(20152609)
end
function c20152614.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152614.filter4(c)
	return c:IsFaceup()
end
function c20152614.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152614.filter4(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152614.filter4,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c20152614.filter4,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c20152614.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetCode(EFFECT_DISABLE)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e4)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(c20152614.efilter4)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c20152614.efilter4(e,te)
	return te:GetOwner()~=e:GetOwner()
end
