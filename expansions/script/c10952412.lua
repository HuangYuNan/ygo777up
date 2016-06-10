--罗星 天蝎座
function c10952412.initial_effect(c)
	c:EnableUnsummonable()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10952412,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c10952412.target)
	e1:SetOperation(c10952412.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetDescription(aux.Stringid(10952412,0))
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c10952412.condtion)
	e2:SetTarget(c10952412.tdtg)
	e2:SetOperation(c10952412.tdop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10952412,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_HAND)
	e5:SetCondition(c10952412.condition2)
	e5:SetTarget(c10952412.target2)
	e5:SetOperation(c10952412.operation2)
	c:RegisterEffect(e5)
	--act limit
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EFFECT_CANNOT_ACTIVATE)
	e8:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e8:SetTargetRange(1,0)
	e8:SetValue(c10952412.aclimit)
	c:RegisterEffect(e8)
	--splimit
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e9:SetTargetRange(1,0)
	e9:SetTarget(c10952412.splimit)
	c:RegisterEffect(e9)
end
function c10952412.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c10952412.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc:IsCode(ac) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	end
end
function c10952412.aclimit(e,re,tp)
	return re:GetHandler():GetType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c10952412.splimit(e,c,tp,sumtp,sumpos)
	return c:IsLevelAbove(5) or not (c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT))
end
function c10952412.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10952412.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c10952412.tdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	end
end
function c10952412.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_DRAW) and e:GetHandler():IsPreviousLocation(LOCATION_DECK) and e:GetHandler():GetPreviousControler()==tp
end
function c10952412.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10952412.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end