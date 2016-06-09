--黑圣女 兔月胡太郎
function c18738105.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEDOWN_DEFENCE,0)
	e1:SetCountLimit(1,187381050)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c18738105.spcon)
	e1:SetOperation(c18738105.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77723643,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,18738105)
	e2:SetCondition(c18738105.descon)
	e2:SetTarget(c18738105.destg)
	e2:SetOperation(c18738105.desop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(18738105,ACTIVITY_SPSUMMON,c18738105.counterfilter)
end
function c18738105.counterfilter(c)
	return  c:IsSetCard(0xab0)
end
function c18738105.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0xab0)
end
function c18738105.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c18738105.rmfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.GetCustomActivityCount(18738105,tp,ACTIVITY_SPSUMMON)==0
end
function c18738105.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	Duel.ConfirmCards(1-tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c18738105.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENCE)
	end
	--oath effects
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c18738105.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c18738105.rmfilter(c)
	return c:IsFaceup()
end
function c18738105.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEDOWN) and (c:IsPreviousLocation(LOCATION_ONFIELD) or c:IsPreviousLocation(LOCATION_DECK))
end
function c18738105.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c18738105.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)~=0 then
		Duel.ConfirmCards(1-tp,c)
	end
end
function c18738105.defilter(c)
	return c:IsCode(18738107)
end