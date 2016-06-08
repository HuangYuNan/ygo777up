--メイドと血の懐中時計
function c233617.initial_effect(c)
    c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
    --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233617,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCost(c233617.spcost)
	e1:SetCondition(c233617.spcon)
	e1:SetTarget(c233617.sptg)
	e1:SetOperation(c233617.spop)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c233617.sumcon)
	e2:SetOperation(c233617.sumsuc)
	c:RegisterEffect(e2)
	--unaffectable
	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_QUICK_O)
    e4:SetCode(EVENT_CHAINING)
    e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c233617.uncon)
	e4:SetOperation(c233617.unop)
    c:RegisterEffect(e4)
end	
function c233617.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c233617.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re and bit.band(re:GetHandler():GetAttribute(),0x20)==0x20 and e:GetHandler():IsPreviousLocation(0x1)
end
function c233617.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,0x4)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c233617.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,1,tp,tp,false,false,0x5)
	end
end
function c233617.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c233617.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c233617.uncon(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER)) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c233617.unop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
	   local e1=Effect.CreateEffect(c)
       e1:SetType(EFFECT_TYPE_SINGLE)
	   e1:SetCode(EFFECT_IMMUNE_EFFECT)
	   e1:SetValue(1)
	   e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	   c:RegisterEffect(e1)
	   local e2=Effect.CreateEffect(c)
	   e2:SetType(EFFECT_TYPE_SINGLE)
	   e2:SetCode(EFFECT_UPDATE_ATTACK)
	   e2:SetValue(1000)
	   e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	   c:RegisterEffect(e2)
	end
end	
	