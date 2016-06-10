--精灵障壁
function c20150321.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c20150321.condition)
	e1:SetTarget(c20150321.target)
	e1:SetOperation(c20150321.activate)
	c:RegisterEffect(e1)
end
function c20150321.filter(c,p)
	return c:IsOnField() and c:IsType(TYPE_MONSTER) and c:GetControler()==p
end
function c20150321.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c20150321.filter,nil,tp)-tg:GetCount()>0
end
function c20150321.sfilter(c,e,tp)
	return c:GetCode()==20150308 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20150321.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c20150321.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if not tc:IsDisabled() then
		Duel.NegateEffect(ev)
		if tc:IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
			local sc=Duel.GetFirstMatchingCard(c20150321.sfilter,tp,LOCATION_DECK,0,nil,e,tp)
			if sc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(20150321,0)) then
				Duel.BreakEffect()
				Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
