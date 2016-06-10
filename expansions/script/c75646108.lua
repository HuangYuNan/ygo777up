--寻星之歌
function c75646108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75646108+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c75646108.target)
	e1:SetOperation(c75646108.activate)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c75646108.atkup)
	c:RegisterEffect(e2)
end
function c75646108.filter(c)
	return c:IsSetCard(0x2c0) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c75646108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646108.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75646108.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75646108.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75646108.atkup(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if not a:IsSetCard(0x2c0) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(600)
	a:RegisterEffect(e1)
end
