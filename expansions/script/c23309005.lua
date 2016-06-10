--鸟之风见幽香
function c23309005.initial_effect(c)
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_DECK)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,23309005)
	e1:SetCondition(c23309005.spcon)
	e1:SetOperation(c23309005.spop)
	c:RegisterEffect(e1)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(23309005,1))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,13300121)
	e5:SetCost(c23309005.thcost2)
	e5:SetTarget(c23309005.thtg2)
	e5:SetOperation(c23309005.thop2)
	c:RegisterEffect(e5)
	if not YuukaGlobal then
		YuukaGlobal={}
		YuukaGlobal["Effects"]={}
	end
	YuukaGlobal["Effects"]["c23309005"]=e5
end
function c23309005.spfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsReleasable()
end
function c23309005.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c23309005.spfilter,tp,LOCATION_HAND,0,nil)
	local mg=Duel.GetMatchingGroup(c23309005.refilter,tp,LOCATION_GRAVE,0,c)
	if e:GetHandler():IsHasEffect(23309009) then g:Merge(mg) end
	if not c:IsAbleToGraveAsCost() then
		g:RemoveCard(c)
	end
	return g:CheckWithSumGreater(Card.GetLevel,8)
end
function c23309005.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c23309005.spfilter,c:GetControler(),LOCATION_HAND,0,nil)
	local mg=Duel.GetMatchingGroup(c23309005.refilter,tp,LOCATION_GRAVE,0,c)
	if e:GetHandler():IsHasEffect(23309009) then g:Merge(mg) end
	if not c:IsAbleToGraveAsCost() then
		g:RemoveCard(c)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:SelectWithSumGreater(tp,Card.GetLevel,8)
	local mg1=sg:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
	local mg2=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if mg1:GetCount()>0 then Duel.Remove(mg1,POS_FACEUP,REASON_COST) end
	if mg2:GetCount()>0 then Duel.Release(mg2,REASON_COST) end
end
function c23309005.costfilter(c,e,tp)
	return c:IsRace(RACE_PLANT) and c:IsReleasable() and (c:IsControler(tp) or c:IsFaceup()) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
end
function c23309005.refilter(c)
	return c:IsSetCard(0x99a) and c:IsAbleToRemoveAsCost()
end
function c23309005.thcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetMatchingGroup(c23309005.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD,nil,e,tp)
	local mg2=Duel.GetMatchingGroup(c23309005.refilter,tp,LOCATION_GRAVE,0,nil)
	if e:GetHandler():IsHasEffect(23309009) then mg1:Merge(mg2) end
	if chk==0 then return mg1:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=mg1:Select(tp,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	else
		Duel.Release(g,REASON_COST)
	end
end
function c23309005.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c23309005.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end