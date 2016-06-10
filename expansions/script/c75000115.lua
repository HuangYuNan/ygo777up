--神之曲 迷糊技师
function c75000115.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),3,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75000115.cost)
	e1:SetTarget(c75000115.target)
	e1:SetOperation(c75000115.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000115,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c75000115.drcon)
	e2:SetCost(c75000115.cost)  
	e2:SetTarget(c75000115.drtg)
	e2:SetOperation(c75000115.drop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75000115,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_REMOVE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(c75000115.thcon)
	e3:SetTarget(c75000115.thtg)
	e3:SetOperation(c75000115.thop)
	c:RegisterEffect(e3)
end
function c75000115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75000115.filter(c)
	return c:IsSetCard(0x52f) and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_PENDULUM))
end
function c75000115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c75000115.filter,tp,LOCATION_MZONE+LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectTarget(tp,c75000115.filter,tp,LOCATION_MZONE+LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,tp,LOCATION_MZONE+LOCATION_SZONE)
end
function c75000115.cfilter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75000115.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	e:SetLabel(tc:GetCode())
	if tc:IsRelateToEffect(e) then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			if Duel.IsExistingMatchingCard(c75000115.cfilter,tp,LOCATION_DECK,0,1,nil,e:GetLabel(),e,tp) then
				if Duel.SelectYesNo(tp,aux.Stringid(75000115,0)) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
					local g=Duel.SelectMatchingCard(tp,c75000115.cfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel(),e,tp)
					Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
				end
			end
		end
	end
end
function c75000115.tfilter(c,tp)
	return c:IsSetCard(0x52f) and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_PENDULUM)) and c:IsPreviousLocation(LOCATION_MZONE) or c:IsPreviousLocation(LOCATION_SZONE) and c:GetPreviousControler()==tp
end
function c75000115.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75000115.tfilter,1,nil,tp)
end
function c75000115.filter2(c)
	return c:IsAbleToDeck()
end
function c75000115.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c75000115.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=Duel.SelectTarget(tp,c75000115.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tc,1,tp,LOCATION_ONFIELD)
end
function c75000115.drop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,nil,REASON_EFFECT)
	end
end
function c75000115.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c75000115.filter3(c)
	return c:IsSetCard(0x52f) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c75000115.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000115.filter3,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c75000115.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000115.filter3,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
end