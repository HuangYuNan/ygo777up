--厄灵 操魂巫妖
require "script/c20329999"
function c20321005.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	local e1=Mfrog.elhsp(c,c20321005)
	local e2=Mfrog.elthce(c,c20321005)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c20321005.tg)
	e3:SetOperation(c20321005.op)
	c:RegisterEffect(e3)
end
function c20321005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
	local g1=Duel.GetMatchingGroup(c20321005.thfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g1:GetCount())
end
function c20321005.thfilter(c)
	return (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)) and c:IsAbleToDeck()
end
function c20321005.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20321005.thfilter,tp,LOCATION_ONFIELD,0,nil)
	local num=Duel.SendtoDeck(g,tp,2,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.Draw(tp,num,REASON_EFFECT)
	Mfrog.elthsp(e,tp)
end
function c20321005.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x281)
end
function c20321005.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return true end
	if chk==0 then return Duel.IsExistingTarget(c20321005.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c20321005.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
end
function c20321005.op(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetFirstTarget()
	local lv=c:GetLevel()
	Duel.ConfirmDecktop(1-tp,lv)
	local g=Duel.GetDecktopGroup(1-tp,lv)
	if g:FilterCount(Card.IsSetCard,nil,0x281)>0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		Duel.SortDecktop(tp,1-tp,lv)
	else
		Duel.SortDecktop(1-tp,1-tp,lv)
	end
end