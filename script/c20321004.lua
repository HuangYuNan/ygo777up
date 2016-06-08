--厄灵 疫病僵尸
require "script/c20329999"
function c20321004.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--to deck
	local e1=Mfrog.eltdce(c,c20321004)
	local e2=Mfrog.elthce(c,c20321004)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(c20321004.con)
	e3:SetTarget(c20321004.tg)
	e3:SetOperation(c20321004.op)
	c:RegisterEffect(e3)
end
function c20321004.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c20321004.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x281) and c:IsType(TYPE_MONSTER)
end
function c20321004.tdop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.eltd(e,tp)
	if Duel.IsExistingMatchingCard(c20321004.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(20321004,0)) then
		local g=Duel.SelectMatchingCard(tp,c20321004.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c20321004.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c20321004.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD,e:GetHandler())
	Mfrog.elthsp(e,tp)
end
function c20321004.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c20321004.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Mfrog.elmtdfilter,tp,LOCATION_DECK,0,4,nil) end
end
function c20321004.op(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elmtd(e,tp,4,LOCATION_DECK)
end