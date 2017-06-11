--和谐的记忆屋
function c75646213.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--CANNOT_ACTIVATE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c75646213.condition)
	e2:SetValue(c75646213.aclimit)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c75646213.retarget1)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1,75646213)
	e4:SetCondition(c75646213.condition1)
	e4:SetTarget(c75646213.target)
	e4:SetOperation(c75646213.operation)
	c:RegisterEffect(e4)
end
function c75646213.cfilter(c)
	return c:IsSetCard(0x2c2)
end
function c75646213.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c75646213.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c75646213.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_COUNTER) and not re:GetHandler():IsImmuneToEffect(e)
end
function c75646213.retarget1(e,c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x2c2)
end
function c75646213.filter(c)
	return c:IsSetCard(0x2c2) and c:IsAbleToHand()
end
function c75646213.condition1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.CheckChainUniqueness()
end
function c75646213.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646213.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75646213.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c75646213.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end