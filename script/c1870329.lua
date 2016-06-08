--月之少女 艾丝特
function c1870329.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCountLimit(1,1870329)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1870329.spcon)
	e1:SetOperation(c1870329.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95027497,0))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,18703290)
	e2:SetTarget(c1870329.tg)
	e2:SetOperation(c1870329.op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c1870329.filter(c)
	return c:IsSetCard(0xab0) and c:IsAbleToGrave()
end
function c1870329.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1870329.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c1870329.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1870329.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		if  c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SelectYesNo(tp,aux.Stringid(1870329,1)) then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
		end
	end
end
function c1870329.rmfilter(c)
	return c:IsAbleToDeckAsCost() and c:IsFacedown()
end
function c1870329.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c1870329.rmfilter,c:GetControler(),LOCATION_REMOVED,0,1,nil,nil)

end
function c1870329.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c1870329.rmfilter,tp,LOCATION_REMOVED,0,1,3,e:GetHandler())
	if g:GetCount()>0 then
	Duel.SendtoDeck(g,nil,1,REASON_COST)
	end
end