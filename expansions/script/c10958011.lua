--无尽游戏
function c10958011.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c10958011.condition)
	e1:SetCountLimit(1,10808011)
	e1:SetTarget(c10958011.target)
	e1:SetOperation(c10958011.activate)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10808011,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_REMOVE)
	e2:SetTarget(c10958011.tdtg)
	e2:SetOperation(c10958011.tdop)
	c:RegisterEffect(e2)
end
function c10958011.cfilter(c)
	return c:IsFaceup() and c:IsCode(10958004)
end
function c10958011.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10958011.cfilter,0,LOCATION_MZONE,0,1,nil) and Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)>=8
end
function c10958011.filter(c)
	return c:IsSetCard(0x236) and c:IsType(TYPE_MONSTER) and not c:IsCode(10958004) and c:IsAbleToHand()
end
function c10958011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10958011.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10958011.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10958011.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c10958011.tdfilter(c)
	return c:IsFacedown() and c:IsAbleToDeck()
end
function c10958011.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c10958011.tdfilter,tp,LOCATION_REMOVED,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c10958011.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10958011.tdfilter,tp,LOCATION_REMOVED,0,nil)
	if Duel.SendtoDeck(g,nil,0,REASON_EFFECT)~=0 then
		Duel.ShuffleDeck(tp)
	end
end