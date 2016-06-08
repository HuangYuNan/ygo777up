--神之曲 爆炎的魔神莉欧
function c75000065.initial_effect(c)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),aux.NonTuner(Card.IsSetCard,0x52f),3)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c75000065.splimit)
	c:RegisterEffect(e0)
	--local e5=Effect.CreateEffect(c)
	--e5:SetType(EFFECT_TYPE_FIELD)
	--e5:SetCode(EFFECT_SPSUMMON_PROC)
	--e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	--e5:SetRange(LOCATION_EXTRA)
	--e5:SetCondition(c75000065.sprcon)
	--e5:SetOperation(c75000065.sprop)
	--e5:SetValue(SUMMON_TYPE_SYNCHRO)
	--c:RegisterEffect(e5)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetTarget(c75000065.splimit2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,0x1c0+TIMING_STANDBY_PHASE)
	e2:SetCountLimit(1)
	e2:SetCost(c75000065.rmcost)
	e2:SetTarget(c75000065.rmtg)
	e2:SetOperation(c75000065.rmop)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCondition(c75000065.ngcon)
	e3:SetOperation(c75000065.ngop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(75000065,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_REMOVE)
	e4:SetCondition(c75000065.ngcon)
	e4:SetOperation(c75000065.sumop)
	c:RegisterEffect(e4)
end
--[[function c75000065.sprfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER) and c:IsSetCard(0x52f)
end
function c75000065.sprfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToGraveAsCost() and c:IsSetCard(0x52f)
end
]]
function c75000065.splimit2(e,c)
	return c:IsLocation(LOCATION_EXTRA)
end
--[[function c75000065.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c75000065.sprfilter1,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.IsExistingMatchingCard(c75000065.sprfilter2,tp,LOCATION_MZONE,0,2,nil,tp)
end
function c75000065.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c75000065.sprfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c75000065.sprfilter2,tp,LOCATION_MZONE,0,2,2,nil)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST+REASON_SYNCHRO)
end
]]
function c75000065.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(75000065)
end
function c75000065.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c75000065.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c75000065.rmfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x52f)
end
function c75000065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c75000065.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c75000065.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75000065.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c75000065.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000065.rmfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,0,0,0,0)
end
function c75000065.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,c75000065.rmfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,e:GetHandler(),e,tp)
	if tc:GetCount()>0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75000065.ngcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c75000065.ngop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	if true then
		--local e1=Effect.CreateEffect(c)
		--e1:SetType(EFFECT_TYPE_FIELD)
		--e1:SetRange(LOCATION_REMOVED)
		--e1:SetTargetRange(0,LOCATION_MZONE)
		--e1:SetTarget(c75000065.disable)
		--e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		--e1:SetCode(EFFECT_DISABLE)
		--c:RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetRange(LOCATION_REMOVED)
		e2:SetTargetRange(0,LOCATION_MZONE)
		e2:SetTarget(c75000065.disable)
		e2:SetValue(0)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2,tp)
	end
end
function c75000065.disable(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT) and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c75000065.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsPreviousLocation(LOCATION_ONFIELD) then
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCountLimit(1)
		e1:SetTarget(c75000065.thtg)
		e1:SetOperation(c75000065.thop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end 
end
function c75000065.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	   and c:IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c75000065.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,true,POS_FACEUP)
	end
end