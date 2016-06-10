--神之曲 幻影夏尔迪奥
function c75000077.initial_effect(c)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),4,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75000077.cost)
	e1:SetTarget(c75000077.target)
	e1:SetOperation(c75000077.operation)
	c:RegisterEffect(e1)
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(75000077,0))
	--e2:SetCategory(CATEGORY_SEARCH)
	--e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	--e2:SetCode(EVENT_REMOVE)
	--e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	--e2:SetCondition(c75000077.con)
	--e2:SetTarget(c75000077.tg)
	--e2:SetOperation(c75000077.op)
	--c:RegisterEffect(e2)
end
function c75000077.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75000077.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c75000077.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local t=Duel.SelectTarget(tp,c75000077.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc=Duel.GetFirstTarget()
	e:SetLabel(tc:GetOriginalRank()*2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,tp,LOCATION_MZONE)
end
function c75000077.filter(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_XYZ) and c:IsAbleToRemove() and Duel.IsExistingMatchingCard(c75000077.cfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetOriginalRank()*2)
end
function c75000077.cfilter(c,e,tp,m)
	return c:IsLevelBelow(m) and c:IsType(TYPE_SYNCHRO) and c:IsSetCard(0x52f) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,true)
end
function c75000077.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then 
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local m=Duel.SelectMatchingCard(tp,c75000077.cfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel())
		Duel.SpecialSummon(m,SUMMON_TYPE_SYNCHRO,tp,tp,true,true,POS_FACEUP)
	end
end
function c75000077.filter2(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_SPELL+TYPE_TRAP) 
end
function c75000077.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c75000077.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000077.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75000077.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000077.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end