--ベイス・キーパー
function c9990104.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Rescue
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1,9990104)
	e1:SetCondition(c9990104.rscon)
	e1:SetTarget(c9990104.rstg)
	e1:SetOperation(c9990104.rsop)
	c:RegisterEffect(e1)
	--Recycling
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9990104,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCost(c9990104.thcost)
	e2:SetTarget(c9990104.thtg)
	e2:SetOperation(c9990104.thop)
	c:RegisterEffect(e2)
	--Scale Change
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c9990104.sctg)
	e3:SetOperation(c9990104.scop)
	c:RegisterEffect(e3)
end
function c9990104.rsfilter(c,seq)
	return c:GetSequence()>seq and c:GetOriginalCode()==9990104
end
function c9990104.rscon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_PENDULUM)
		and not Duel.IsExistingMatchingCard(c9990104.rsfilter,tp,LOCATION_DECK,0,1,nil,c:GetSequence())
end
function c9990104.spfilter(c,e,tp)
	return c:IsCode(9990104) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9990104.rstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c9990104.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.ConfirmCards(1-tp,e:GetHandler())
end
function c9990104.rsop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c9990104.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c9990104.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c9990104.thfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c9990104.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9990104.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c9990104.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9990104.thfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c9990104.scfilter(c,seq,lsc,rsc)
	if not c:IsType(TYPE_PENDULUM) then return false end
	if seq==6 then
		return c:GetLeftScale()~=lsc
	else
		return c:GetRightScale()~=rsc
	end
end
function c9990104.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local seq,lsc,rsc=c:GetSequence(),c:GetLeftScale(),c:GetRightScale()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c9990104.scfilter(chkc,seq,lsc,rsc) and c:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c9990104.scfilter,tp,LOCATION_GRAVE,0,1,nil,seq,lsc,rsc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c9990104.scfilter,tp,LOCATION_GRAVE,0,1,1,nil,seq,lsc,rsc)
end
function c9990104.scop(e,tp,eg,ep,ev,re,r,rp)
	local c,tc=e:GetHandler(),Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not c:IsRelateToEffect(e) then return end
	local val,code=tc:GetLeftScale(),EFFECT_CHANGE_LSCALE
	if c:GetSequence()==6 then
		if c:GetLeftScale()==val then return end
	else
		val,code=tc:GetRightScale(),EFFECT_CHANGE_RSCALE
		if c:GetRightScale()==val then return end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
