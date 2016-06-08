require "script/c20329999"
function c20321011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c20321011.condition)
	e2:SetTarget(c20321011.target)
	e2:SetOperation(c20321011.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c20321011.con2)
	e3:SetTarget(c20321011.tg2)
	e3:SetOperation(c20321011.op2)
	c:RegisterEffect(e3)
end
function c20321011.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:GetControler()==1-tp
end
function c20321011.filter2(c,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsControler(1-tp)
end
function c20321011.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20321011.filter,1,nil,tp)
end
function c20321011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,0)
end
function c20321011.operation(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elmtd(e,tp,1,LOCATION_DECK)
end
function c20321011.con2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20321011.filter2,1,nil,tp)
end
function c20321011.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c20321011.filter3(c)
	return c:IsSetCard(0x281) and c:IsType(TYPE_MONSTER) and c:GetControler()~=c:GetOwner()
end
function c20321011.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroupCount(c20321011.filter3,tp,0,LOCATION_DECK,nil)<1 then return end
	local g=Duel.GetMatchingGroup(c20321011.filter3,tp,0,LOCATION_DECK,nil):RandomSelect(tp,1)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(1-tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(1-tp,1)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end