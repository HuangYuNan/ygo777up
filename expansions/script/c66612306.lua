--扑克魔术的杀意
function c66612306.initial_effect(c)
	c:SetUniqueOnField(1,0,66612306)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66612306,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c66612306.hspcost)
	e1:SetTarget(c66612306.hsptg)
	e1:SetOperation(c66612306.hspop)
	c:RegisterEffect(e1)
	if not c66612306.global_check then
		c66612306.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612306.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612306.clear)
		Duel.RegisterEffect(ge2,0)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c66612306.negcost)
	e2:SetTarget(c66612306.negtg)
	e2:SetOperation(c66612306.negop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66612306,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetCost(c66612306.cost)
	e3:SetTarget(c66612306.target)
	e3:SetOperation(c66612306.operation)
	c:RegisterEffect(e3)
	if not c66612306.global_check then
		c66612306.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66612306.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66612306.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c66612306.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x660) then
			c66612306[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66612306.clear(e,tp,eg,ep,ev,re,r,rp)
	c66612306[0]=true
	c66612306[1]=true
end
function c66612306.rfilter(c)
	return c:IsSetCard(0x660) and c:IsAbleToDeckAsCost() and c:IsType(TYPE_MONSTER)
end
function c66612306.hspcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612306.rfilter,tp,LOCATION_REMOVED+LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c66612306.rfilter,tp,LOCATION_REMOVED+LOCATION_MZONE,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c66612306.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66612306.hspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66612306.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c66612306.negfilter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup()
end
function c66612306.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c66612306.negfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c66612306.negfilter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c66612306.negfilter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c66612306.negop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c66612306.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() and c66612306[tp] end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c66612306.filter(c)
	return c:GetCode()==66612320 and c:IsAbleToHand()
end
function c66612306.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612306.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66612306.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c66612306.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end