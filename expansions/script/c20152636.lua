--ALO•西莉卡
function c20152636.initial_effect(c)
c:SetUniqueOnField(1,1,20152614)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152636.ovfilter,aux.Stringid(20152636,7),3,nil)
	c:EnableReviveLimit()
		--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c20152636.sptg)
	e1:SetOperation(c20152636.spop)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20152636.condition2)
	e2:SetTarget(c20152636.target3)
	e2:SetOperation(c20152636.operation3)
	c:RegisterEffect(e2)
			--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152636,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c20152636.cost)
	e3:SetTarget(c20152636.target)
	e3:SetOperation(c20152636.operation)
	c:RegisterEffect(e3)
end
function c20152636.ovfilter(c)
	return c:IsCode(20152606) and c:IsFaceup()
end
function c20152636.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152606)
end
	function c20152636.filter(c,e,tp)
	return c:IsCode(20152609) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c20152636.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20152636.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
	Duel.SetChainLimit(aux.FALSE)
end
function c20152636.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152636.filter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c20152636.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152636.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup() and c:IsDestructable()
end
function c20152636.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c20152636.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c20152636.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c20152636.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c20152636.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end

function c20152636.filter3(c)
	return c:IsFaceup() and c:IsCode(20152609)
end
function c20152636.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152636.filter3,tp,LOCATION_MZONE,0,1,nil) end
end
function c20152636.operation3(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20152636.filter3,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
