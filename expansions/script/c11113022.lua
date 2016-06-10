--战场女武神 尤利娅娜 人造瓦尔基里
function c11113022.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113022,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,11113022)
	e2:SetCost(c11113022.spcost)
	e2:SetTarget(c11113022.sptg)
	e2:SetOperation(c11113022.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113022,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,111130220)
	e3:SetCost(c11113022.descost)
	e3:SetTarget(c11113022.destg)
	e3:SetOperation(c11113022.desop)
	c:RegisterEffect(e3)
	--index
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11113022,2))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,1111302200)
	e4:SetCost(c11113022.indcost)
	e4:SetTarget(c11113022.indtg)
	e4:SetOperation(c11113022.indop)
	c:RegisterEffect(e4)
end
function c11113022.mat_filter(c)
	return c:GetLevel()~=7
end
function c11113022.spfilter1(c,tp)
	return c:IsFaceup() and c:IsCode(11113020) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c11113022.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c11113022.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:GetLevel()==4 and c:IsAbleToRemoveAsCost()
end
function c11113022.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113022.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c11113022.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c11113022.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c11113022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11113022.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
	end
end
function c11113022.dfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsAbleToDeckAsCost()
end	
function c11113022.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113022.dfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c11113022.dfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c11113022.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c11113022.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c11113022.desfilter(chkc) end
	if chk==0 then return e:GetHandler():IsDestructable()
	    and Duel.IsExistingTarget(c11113022.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11113022.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c11113022.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then 
	    Duel.Destroy(Group.FromCards(tc,e:GetHandler()),REASON_EFFECT)
	end
end
function c11113022.indcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c11113022.infilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and bit.band(c:GetType(),0x81)==0x81
end
function c11113022.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c11113022.infilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113022.infilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c11113022.infilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c11113022.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c11113022.imfilter)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c11113022.imfilter(e,re)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end