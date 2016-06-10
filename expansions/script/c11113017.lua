--战场女武神 维鲁金
function c11113017.initial_effect(c)
    --pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c11113017.splimit)
	c:RegisterEffect(e2)
    --special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113017,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,11113017)
	e3:SetCondition(c11113017.condition)
	e3:SetTarget(c11113017.target)
	e3:SetOperation(c11113017.operation)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--salvage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(11113017,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_REMOVE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCountLimit(1,11113017)
	e5:SetTarget(c11113017.settg)
	e5:SetOperation(c11113017.setop)
	c:RegisterEffect(e5)
end
function c11113017.splimit(e,c)
	return not (c:IsSetCard(0x15c) or c:IsType(TYPE_SYNCHRO))
end
function c11113017.condition(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return pc and pc:IsSetCard(0x15c)
end
function c11113017.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsDestructable()
		and Duel.IsExistingMatchingCard(c11113017.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp,c:GetCode())
end
function c11113017.spfilter(c,e,tp,code)
	return c:IsSetCard(0x15c) and not c:IsCode(code) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11113017.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c11113017.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c11113017.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11113017.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c11113017.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not e:GetHandler():IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local code=tc:GetCode()
	if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c11113017.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp,code)
	if sg:GetCount()>0 then
	    Duel.HintSelection(sg)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c11113017.setfilter(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_PENDULUM) and not c:IsCode(11113017)
end
function c11113017.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113017.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c11113017.setop(e,tp,eg,ep,ev,re,r,rp)
   Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113017,2))
	local g=Duel.SelectMatchingCard(tp,c11113017.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoExtraP(g,nil,REASON_EFFECT)
	end
end