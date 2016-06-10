--μ's 西木野真姬
function c20152804.initial_effect(c)
c:SetUniqueOnField(1,1,20152804)
	--send replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c20152804.repcon)
	e1:SetOperation(c20152804.repop)
	c:RegisterEffect(e1)
	--place
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152804,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c20152804.condition)
	e2:SetCost(c20152804.cost)
	e2:SetTarget(c20152804.target)
	e2:SetOperation(c20152804.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152804,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON) 
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_TO_HAND)
	e4:SetCountLimit(1)
	e4:SetCondition(c20152804.spcon)
	e4:SetTarget(c20152804.sptg)
	e4:SetOperation(c20152804.spop)
	c:RegisterEffect(e4)
end
function c20152804.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c20152804.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
	Duel.RaiseEvent(c,20152808,e,0,tp,0,0)
end
function c20152804.cffilter(c)
	return c:IsSetCard(0x9290) and not c:IsPublic()
end
function c20152804.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152804.cffilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c20152804.cffilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c20152804.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=1 and Duel.GetCurrentPhase()==PHASE_MAIN1
		and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_BP) and Duel.IsExistingTarget(c20152804.filter5,tp,LOCATION_SZONE,0,1,nil)
end
function c20152804.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9290) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c20152804.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20152804.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152804.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c20152804.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c20152804.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(c20152804.value)
		tc:RegisterEffect(e1)
	end
end
function c20152804.filter5(c)
	return c:IsSetCard(0x9290) and c:IsFaceup()
end
function c20152804.value(e,c)
	return Duel.GetMatchingGroupCount(c20152804.filter5,c:GetControler(),LOCATION_SZONE,0,nil)
end
function c20152804.cfilter(c,tp)
	return c:IsSetCard(0x9290) and c:GetPreviousControler()==tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c20152804.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20152804.cfilter,1,nil,tp)
end
function c20152804.filter9(c,e,tp)
	return c:IsSetCard(0x9290)
		and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20152804.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingMatchingCard(c20152804.filter9,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c20152804.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152804.filter9,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
