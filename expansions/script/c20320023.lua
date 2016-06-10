--Aru
function c20320023.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c20320023.thcon)
	e2:SetTarget(c20320023.thtg)
	e2:SetOperation(c20320023.thop)
	c:RegisterEffect(e2)
end
function c20320023.thcon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
end
function c20320023.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	local sc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	if chk==0 then return sc:IsSetCard(0x280) and sc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(sc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20320023.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Group.FromCards(tc,c)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end