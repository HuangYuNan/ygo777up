--厄灵 疫病僵尸
require "script/c20329999"
function c20321002.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--to deck
	local e1=Mfrog.eltdce(c,c20321002)
	local e2=Mfrog.elthce(c,c20321002)
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_SPECIAL_SUMMON)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetCode(EVENT_DRAW)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20321002.condition)
	e3:SetOperation(c20321002.op)
	c:RegisterEffect(e3)
end
function c20321002.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c20321002.tdop(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.eltd(e,tp)
	if Duel.IsExistingMatchingCard(IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(20321002,0)) then
		local g=Duel.SelectMatchingCard(tp,IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end
end
function c20321002.disfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c20321002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
end
function c20321002.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c20321002.disfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.AdjustInstantly()
	Mfrog.elthsp(e,tp)
end
function c20321002.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RULE and ep==Duel.GetTurnPlayer()
end
function c20321002.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1-Duel.GetTurnPlayer(),1,REASON_EFFECT)
end