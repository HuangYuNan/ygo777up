--机动要塞 空中母舰
function c1874705.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1874705+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	--tuner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c1874705.target)
	e2:SetOperation(c1874705.activate)
	c:RegisterEffect(e2)
	--cannot disable summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xaab2))
	c:RegisterEffect(e3)
	--cannot disable summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xaab2))
	c:RegisterEffect(e3)
	--cannot disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,0)
	e3:SetTarget(c1874705.target1)
	c:RegisterEffect(e3)
	--inactivatable
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_FIELD)
	--e4:SetCode(EFFECT_CANNOT_INACTIVATE)
	--e4:SetRange(LOCATION_SZONE)
	--e4:SetTarget(c1874705.target1)
	--e4:SetValue(c1874705.effectfilter)
	--c:RegisterEffect(e4)
	--local e5=Effect.CreateEffect(c)
	--e5:SetType(EFFECT_TYPE_FIELD)
	--e5:SetCode(EFFECT_CANNOT_DISEFFECT)
	--e5:SetRange(LOCATION_SZONE)
	--e5:SetTarget(c1874705.target1)
	--e5:SetValue(c1874705.effectfilter)
	--c:RegisterEffect(e5)
end
function c1874705.target1(e,c)
	return c:IsSetCard(0xaab2)
end
function c1874705.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	local tc=te:GetHandler()
	return p==tp and tc:IsSetCard(0xaab2)
end
function c1874705.filter(c)
	return c:IsSetCard(0xaab2) and c:IsFaceup() and c:IsAbleToDeck()
end
function c1874705.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1874705.filter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c1874705.thfilter,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(c1874705.filter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1874705.thfilter(c)
	return c:IsSetCard(0xaab2)  and c:IsAbleToHand()
end
function c1874705.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c1874705.filter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,nil)
	local g=Duel.GetMatchingGroup(c1874705.thfilter,tp,LOCATION_DECK,0,nil)
	if tg:GetCount()>0 and g:GetCount()>0 then
		Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:Select(tp,1,1,nil)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end