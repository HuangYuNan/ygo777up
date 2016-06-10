--神之曲 神龙诺耶利亚
function c75000075.initial_effect(c)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),aux.NonTuner(Card.IsSetCard,0x52f),2)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c75000075.splimit)
	c:RegisterEffect(e0)
	--handes
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(75000075,0))
	--e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	--e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c75000075.hdcon)
	--e1:SetTarget(c75000075.hdtg)
	e1:SetOperation(c75000075.hdop)
	c:RegisterEffect(e1)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20000023,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c75000075.condition)
	e2:SetTarget(c75000075.target)
	e2:SetOperation(c75000075.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCountLimit(1,75000075)
	e3:SetCondition(c75000075.con)
	e3:SetCost(c75000075.cost)
	e3:SetTarget(c75000075.tg)
	e3:SetOperation(c75000075.op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_TO_GRAVE)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e5)
end
function c75000075.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(75000075)
end
function c75000075.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c75000075.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER)
end
function c75000075.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c75000075.cfilter,1,nil,1-tp) and Duel.IsExistingMatchingCard(c75000075.filter2,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end 
function c75000075.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
end
function c75000075.hdop(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
function c75000075.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c75000075.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,0,0,1-tp,1)
end
function c75000075.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	local sg=g:RandomSelect(ep,1)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
function c75000075.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000075.cfilter2,tp,LOCATION_HAND,0,1,nil) end
	local tg=Duel.SelectMatchingCard(tp,c75000075.cfilter2,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(tg,POS_FACEUP,REASON_COST)
end
function c75000075.cfilter2(c)
	return c:IsAbleToRemoveAsCost()
end
function c75000075.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c75000075.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetTargetCard(e:GetHandler())
end
function c75000075.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end