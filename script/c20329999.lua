Mfrog=Mfrog or {}
--el to deck
function Mfrog.eltdce(c,cg)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(Mfrog.eltdcost)
	e1:SetTarget(cg.tdtg)
	e1:SetOperation(cg.tdop)
	c:RegisterEffect(e1)
	return e1
end
function Mfrog.eltdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function Mfrog.eltd(e,tp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
	if not c:IsLocation(LOCATION_DECK) then return end
	Duel.ShuffleDeck(1-tp)
	c:ReverseInDeck()
	Duel.BreakEffect()
end

function Mfrog.elmtd(e,tp,number,location)
	if Duel.GetMatchingGroupCount(Mfrog.elmtdfilter,tp,location,0,nil)<number then return end
	local g=Duel.SelectMatchingCard(tp,Mfrog.elmtdfilter,tp,location,0,number,number,nil)
	local c=g:GetFirst()
	local num=g:GetCount()
	for i=1,num,1 do
		Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
		c:ReverseInDeck()
		c=g:GetNext()
	end
	Duel.ShuffleDeck(1-tp)
end

--el to hand
function Mfrog.elthce(c,cg)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCondition(Mfrog.spcon)
	e2:SetTarget(cg.thtg)
	e2:SetOperation(cg.thop)
	c:RegisterEffect(e2)
	return e2
end
function Mfrog.thops(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function Mfrog.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK) and e:GetHandler():IsControler(1-e:GetHandler():GetOwner())
end
function Mfrog.elthsp(e,tp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,1-tp,false,false,POS_FACEUP_DEFENCE)
	end
end
function Mfrog.jfcost(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsReleasable() end
		Duel.Release(e:GetHandler(),REASON_COST)
end
function Mfrog.elmtdfilter(c)
	return c:IsSetCard(0x281) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_SYNCHRO)
end
 --spsummon from hand
function Mfrog.elhsp(c,cg)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(Mfrog.hspcon)
	e1:SetOperation(Mfrog.hspop)
	c:RegisterEffect(e1)
	return e1
end
function Mfrog.hspcon(e,c)
	if c==nil then return true end
	return (Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),Mfrog.hspfilter,1,nil)) or (Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.CheckReleaseGroup(1-c:GetControler(),Mfrog.hspfilter,1,nil))
end
function Mfrog.hspfilter(c)
	return c:IsSetCard(0x281) and not c:IsType(TYPE_SYNCHRO)
end
function Mfrog.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,Mfrog.hspfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
	local c=g:GetFirst()
	Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
	if not c:IsLocation(LOCATION_DECK) then return end
	Duel.ShuffleDeck(1-tp)
	c:ReverseInDeck()
end
function Mfrog.skdqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end