--厄灵 死亡骑士
require "script/c20329999"
function c20321008.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),aux.NonTuner(c20321008.synfilter),1)
	c:EnableReviveLimit()
	--td1
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20321008,0))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c20321008.tdcon1)
	e4:SetTarget(c20321008.tdtg1)
	e4:SetOperation(c20321008.tdop1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	--cannot activate
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_ACTIVATE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c20321008.effcon)
	c:RegisterEffect(e6)
	--reload
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20321008,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c20321008.cost)
	e2:SetTarget(c20321008.drtg)
	e2:SetOperation(c20321008.drop)
	c:RegisterEffect(e2)
end
function c20321008.synfilter(c)
	return c:GetDefence()==0
end
function c20321008.tdcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20321008.cfilter,1,nil,1-tp)
end
function c20321008.tdtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,0)
end
function c20321008.cfilter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c20321008.tdop1(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elmtd(e,tp,1,LOCATION_DECK)
end
function c20321008.effcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandler():GetControler()
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	return tc:IsSetCard(0x281) and tc:GetControler()~=tc:GetOwner()
end
function c20321008.tdfilter(c)
	return c:IsAbleToDeckAsCost() and c:IsSetCard(0x281) and c:IsType(TYPE_MONSTER)
end
function c20321008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20321008.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c20321008.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c20321008.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp) and h2~=0
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c20321008.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if Duel.SendtoDeck(g,nil,0,REASON_EFFECT)~=0 then
		local og=g:Filter(Card.IsLocation,nil,LOCATION_DECK)
		if og:IsExists(Card.IsControler,1,nil,tp) then Duel.ShuffleDeck(tp) end
		if og:IsExists(Card.IsControler,1,nil,1-tp) then Duel.ShuffleDeck(1-tp) end
		Duel.BreakEffect()
		local ct2=og:FilterCount(aux.FilterEqualFunction(Card.GetPreviousControler,1-tp),nil)
		Duel.Draw(1-tp,ct2,REASON_EFFECT)
	end
end