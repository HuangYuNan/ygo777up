--星愿 四不像
function c2146004.initial_effect(c)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c2146004.spcon)
	e2:SetOperation(c2146004.spop)
	c:RegisterEffect(e2)
	--Tohand
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetCountLimit(1,2146004)
	e4:SetCondition(c2146004.condition)
	e4:SetCost(c2146004.sumcost)
	e4:SetTarget(c2146004.thtg)
	e4:SetOperation(c2146004.thop)
	c:RegisterEffect(e4)
end
function c2146004.spfilter(c)
	return not c:IsPublic() and c:IsSetCard(0x217) 
end
function c2146004.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c2146004.spfilter,c:GetControler(),LOCATION_HAND,0,1,e:GetHandler())
end
function c2146004.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c2146004.spfilter,c:GetControler(),LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c2146004.cfilter(c,tp)
	return c:IsSetCard(0x217) and c:IsType(TYPE_MONSTER) and not c:IsCode(2146004)
end
function c2146004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2146004.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c2146004.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c2146004.thfilter(c)
	return c:IsSetCard(0x217) and not c:IsCode(2146004) and c:IsAbleToHand()
end
function c2146004.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2146004.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2146004.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2146004.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end