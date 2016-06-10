--战场女武神 赛尔杰
function c11113028.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c11113028.splimit)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113028,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,11113028)
	e3:SetCondition(c11113028.spcon)
	e3:SetCost(c11113028.spcost)
	e3:SetTarget(c11113028.sptg)
	e3:SetOperation(c11113028.spop)
	c:RegisterEffect(e3)
	--to pzone
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11113029,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_REMOVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,11113028)
	e4:SetCondition(c11113028.mvcon)
	e4:SetTarget(c11113028.mvtg)
	e4:SetOperation(c11113028.mvop)
	c:RegisterEffect(e4)
	Duel.AddCustomActivityCounter(11113028,ACTIVITY_ATTACK,c11113028.counterfilter)
end
function c11113028.counterfilter(c)
	return c:IsSetCard(0x15c)
end
function c11113028.splimit(e,c)
	return not (c:IsSetCard(0x15c) or c:IsType(TYPE_SYNCHRO))
end
function c11113028.spcon(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return pc and pc:IsSetCard(0x15c)
end
function c11113028.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(11113028,tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c11113028.ftarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11113028.ftarget(e,c)
	return not c:IsSetCard(0x15c)
end
function c11113028.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsLevelBelow(4) and not c:IsCode(11113028) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11113028.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c11113028.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsDestructable()
		and Duel.IsExistingTarget(c11113028.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c11113028.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c11113028.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.Destroy(c,REASON_EFFECT)~=0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end	
end
function c11113028.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:GetHandler():IsSetCard(0x15c)
end
function c11113028.mvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c11113028.mvop(e,tp,eg,ep,ev,re,r,rp)
    if not (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
	    Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_DECKBOT)
		c:RegisterEffect(e1)
	end	
end