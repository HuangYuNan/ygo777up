--战场女武神 伊姆卡
function c11113008.initial_effect(c)
    --pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c11113008.splimit)
	c:RegisterEffect(e2)
    --salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113008,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,11113008)
	e3:SetCondition(c11113008.condition)
	e3:SetTarget(c11113008.target)
	e3:SetOperation(c11113008.operation)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--salvage2
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(11113006,1))
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_REMOVE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1,11113008)
	e5:SetTarget(c11113008.rttg)
	e5:SetOperation(c11113008.rtop)
	c:RegisterEffect(e5)
end
function c11113008.splimit(e,c)
	return not (c:IsSetCard(0x15c) or c:IsType(TYPE_SYNCHRO))
end
function c11113008.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:IsSetCard(0x15c) and not c:IsCode(11113008)
end
function c11113008.condition(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return eg:IsExists(c11113008.cfilter,1,nil,tp) and pc and pc:IsSetCard(0x15c)
end	
function c11113008.filter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
	    and c:IsSetCard(0x15c) and c:IsLevelBelow(4) and not c:IsCode(11113008) and c:IsAbleToHand()
end
function c11113008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsDestructable()
	    and Duel.IsExistingMatchingCard(c11113008.filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end
function c11113008.operation(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c11113008.filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
		if g:GetCount()>0 then
		    Duel.HintSelection(g)
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end	
end
function c11113008.rtfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsLevelBelow(4) and not c:IsCode(11113008) and c:IsAbleToHand()
end
function c11113008.rttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c11113008.rtfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113008.rtfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c11113008.rtfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c11113008.rtop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end