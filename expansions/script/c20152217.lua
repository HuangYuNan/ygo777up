--中二病也要谈恋爱
function c20152217.initial_effect(c)
c:SetUniqueOnField(1,0,20152217)
	--Activate
		local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,20152217)
	e1:SetTarget(c20152217.target)
		e1:SetOperation(c20152217.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152217,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c20152217.drcon)
	e2:SetTarget(c20152217.drtg)
	e2:SetOperation(c20152217.drop)
	c:RegisterEffect(e2)
end
function c20152217.tgfilter(c)
	return c:IsSetCard(0x3290) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c20152217.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152217.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c20152217.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20152217.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c20152217.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c20152217.filter(c)
	return c:IsSetCard(0x3290) and c:GetCode()~=20152217 and c:IsAbleToDeck()
end
function c20152217.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingMatchingCard(c20152217.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c20152217.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c20152217.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoDeck(g,nil,1,REASON_EFFECT)>0 then
	Duel.ShuffleDeck(tp)
		Duel.ConfirmCards(1-tp,g)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
