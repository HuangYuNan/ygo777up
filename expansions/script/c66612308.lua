--扑克魔术 白水晶
function c66612308.initial_effect(c)
	aux.AddFusionProcFun2(c,c66612308.filter1,c66612308.filter2,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612308.sprcon)
	e1:SetOperation(c66612308.sprop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c66612308.condition)
	e2:SetTarget(c66612308.target)
	e2:SetOperation(c66612308.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612308.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCountLimit(1)
	e4:SetValue(c66612308.valcon)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e5:SetCondition(c66612308.descon)
	e5:SetTarget(c66612308.destg)
	e5:SetOperation(c66612308.desop)
	c:RegisterEffect(e5)
end
function c66612308.filter1(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612308.filter2(c)
	return (c:GetLevel()==2 or c:GetLevel()==6) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612308.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3660)
end
function c66612308.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(fc)
		and Duel.IsExistingMatchingCard(c66612308.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612308.spfilter2(c,fc)
	return (c:GetLevel()==2 or c:GetLevel()==6) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612308.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612308.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c66612308.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612308,0))
	local g1=Duel.SelectMatchingCard(tp,c66612308.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612308,1))
	local g2=Duel.SelectMatchingCard(tp,c66612308.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Remove(g1,nil,2,REASON_COST)
end
function c66612308.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x660) and c:IsLevelBelow(4)
end
function c66612308.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c66612308.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c66612308.cfilter,1,nil,1-tp)
end
function c66612308.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c66612308.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function c66612308.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c66612308.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonLocation()==LOCATION_EXTRA 
end
function c66612308.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c66612308.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c66612308.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c66612308.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c66612308.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end