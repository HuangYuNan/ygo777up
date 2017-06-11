--shunliutupo
function c100170011.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100170011.cost)
	e1:SetTarget(c100170011.tg)
	e1:SetOperation(c100170011.op)
	c:RegisterEffect(e1)
end
function c100170011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)>5000 end
	Duel.PayLPCost(tp,5000)
end
function c100170011.filter(c,e,tp)
	return c:IsSetCard(0x5cd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,0,0,1,nil,c:GetCode())
end
function c100170011.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c100170011.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c100170011.op(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(c100170011.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	while g:GetCount()>0 and ft>0 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummonStep(sg:GetFirst(), 0, tp, tp, false, false, POS_FACEUP)
		ft=ft-1
		g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
	end
	Duel.SpecialSummonComplete()
end