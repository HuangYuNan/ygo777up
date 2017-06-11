--shanjianxixi
function c100170018.initial_effect(c)
	-- sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c100170018.condition)
	e1:SetTarget(c100170018.sptg)
	e1:SetCountLimit(1,100170018)
	e1:SetOperation(c100170018.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,100170018)
	e3:SetTarget(c100170018.thtg)
	e3:SetOperation(c100170018.thop)
	c:RegisterEffect(e3)
end
function c100170018.thfilter(c)
	return (c:IsType(TYPE_EQUIP)and c:IsType(TYPE_SPELL)) or (c:IsType(TYPE_MONSTER) and c:IsType(TYPE_UNION)) and c:IsAbleToHand()
end
function c100170018.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100170018.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c100170018.thop(e,tp,eg,ep,ev,re,r,rp)
local sg=Duel.GetMatchingGroup(c100170018.thfilter,tp,LOCATION_GRAVE,0,nil)
	if sg and sg:GetCount()~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local rg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(rg)
		Duel.SendtoHand(rg,nil,REASON_EFFECT)
	end
end
function c100170018.cfilter(c,tp)
	return c:IsSetCard(0x5cd) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c100170018.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100170018.cfilter,1,nil,tp)
end
function c100170018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100170018.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end