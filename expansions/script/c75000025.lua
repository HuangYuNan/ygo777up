--神之曲 远见之章
function c75000025.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75000025,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,75000025)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTarget(c75000025.target)
	e1:SetOperation(c75000025.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000025,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,75000025)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTarget(c75000025.rmtg)
	e2:SetOperation(c75000025.rmop)
	c:RegisterEffect(e2)
end
function c75000025.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER)
end
function c75000025.filter4(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c75000025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000025.filter4,tp,LOCATION_DECK,0,1,nil) and Duel.IsPlayerCanDraw(1) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c75000025.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if not Duel.IsPlayerCanDraw(1) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c75000025.filter4,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoGrave(g1,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c75000025.filter2(c,e,sp)
	return c:IsSetCard(0x52f) and c:IsAbleToRemove()
end
function c75000025.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c75000025.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c75000025.filter2,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c75000025.filter2,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c75000025.filter3(c,e)
	return c:IsAbleToRemove() and (not e or c:IsRelateToEffect(e))
end
function c75000025.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c75000025.filter3,nil,e)
	local tc=g:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c75000025.retop)
	Duel.RegisterEffect(e1,tp)
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,tc:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)
		tc:RegisterFlagEffect(75000025,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c75000025.retfilter(c)
	return c:GetFlagEffect(75000025)~=0
end
function c75000025.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75000025.retfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ReturnToField(tc)
	end 
end
function c75000025.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c75000025.cfilter(c)
	return c:IsCode(75000025) and c:IsAbleToHand()
end

function c75000025.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000025.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75000025.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000025.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end