--罗星 处女座
function c10952410.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10952410,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,10952410)
	e1:SetTarget(c10952410.sptg)
	e1:SetOperation(c10952410.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetDescription(aux.Stringid(10952410,0))
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c10952410.condtion)
	e2:SetTarget(c10952410.tdtg)
	e2:SetOperation(c10952410.tdop)
	c:RegisterEffect(e2)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10952410,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_HAND)
	e5:SetCondition(c10952410.condition2)
	e5:SetTarget(c10952410.target2)
	e5:SetOperation(c10952410.operation2)
	c:RegisterEffect(e5)
	--act limit
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EFFECT_CANNOT_ACTIVATE)
	e8:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e8:SetTargetRange(1,0)
	e8:SetValue(c10952410.aclimit)
	c:RegisterEffect(e8)
	--splimit
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e9:SetTargetRange(1,0)
	e9:SetTarget(c10952410.splimit)
	c:RegisterEffect(e9)
end
function c10952410.filter(c,e,tp)
	return c:IsSetCard(0x233) and c:IsLevelBelow(2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10952410.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10952410.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c10952410.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10952410.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10952410.aclimit(e,re,tp)
	return re:GetHandler():GetType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c10952410.splimit(e,c,tp,sumtp,sumpos)
	return c:IsLevelAbove(5) or not (c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT))
end
function c10952410.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10952410.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c10952410.tdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	end
end
function c10952410.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_DRAW) and e:GetHandler():IsPreviousLocation(LOCATION_DECK)  and e:GetHandler():GetPreviousControler()==tp
end
function c10952410.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10952410.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end