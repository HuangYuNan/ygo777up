--厄灵 夺魄死神
require "script/c20329999"
function c20321006.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	local e1=Mfrog.elhsp(c,c20321006)
	local e2=Mfrog.elthce(c,c20321006)
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetTarget(c20321006.tg)
	e3:SetOperation(c20321006.op)
	c:RegisterEffect(e3)
end
function c20321006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Mfrog.thops(e)
	local g=Duel.GetMatchingGroup(c20321006.posfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0) end
end
function c20321006.posfilter(c)
	return c:IsCanTurnSet()
end
function c20321006.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20321006.posfilter,tp,LOCATION_MZONE,0,nil)
	if Duel.ChangePosition(g,POS_FACEDOWN_DEFENCE)~=0 then
		local og=Duel.GetOperatedGroup()
		local tc=og:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc=og:GetNext()
		end
	end
	Mfrog.elthsp(e,tp)
end
function c20321006.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) and Duel.IsExistingMatchingCard(Mfrog.elmtdfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20321006.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	Mfrog.elmtd(e,tp,1,LOCATION_DECK)
end