--厄灵 脆骨骷髅
require "script/c20329999"
function c20321001.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--to deck
	local e1=Mfrog.eltdce(c,c20321001)
	local e2=Mfrog.elthce(c,c20321001)
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(Mfrog.jfcost)
	e3:SetTarget(c20321001.sptg)
	e3:SetOperation(c20321001.spop)
	c:RegisterEffect(e3)
end
function c20321001.thfilter(c)
	return (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)) and c:IsAbleToHand() and c:IsSetCard(0x281)
end
function c20321001.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c20321001.tdop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.eltd(e,tp)
	if Duel.IsExistingMatchingCard(c20321001.thfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(20321001,0)) then
		local g=Duel.SelectMatchingCard(tp,c20321001.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c20321001.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c20321001.thop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elthsp(e,tp)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
function c20321001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Mfrog.elmtdfilter,tp,LOCATION_DECK,0,3,nil) and Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c20321001.spop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elmtd(e,tp,3,LOCATION_DECK)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end