--厄灵 彷徨幽魂
require "script/c20329999"
function c20321003.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--to deck
	local e1=Mfrog.eltdce(c,c20321003)
	local e2=Mfrog.elthce(c,c20321003)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c20321003.op)
	c:RegisterEffect(e3)
end
function c20321003.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c20321003.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsSetCard(0x281) and not c:IsCode(20321003)
end
function c20321003.tdop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.eltd(e,tp)
	if Duel.IsExistingMatchingCard(c20321003.thfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(20321003,0)) then
		local g=Duel.SelectMatchingCard(tp,c20321003.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c20321003.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
end
function c20321003.thop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
		  e1:SetType(EFFECT_TYPE_FIELD)
		  e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		  e1:SetTargetRange(1,0)
		  e1:SetValue(1)
		  e1:SetReset(RESET_PHASE+PHASE_END,2)
		  Duel.RegisterEffect(e1,1-tp)
	Mfrog.elthsp(e,tp)
end
function c20321003.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.ShuffleDeck(1-tp)
	Duel.SortDecktop(tp,1-tp,3)
end