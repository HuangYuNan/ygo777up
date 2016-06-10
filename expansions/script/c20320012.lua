--
function c20320012.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c20320012.thtg)
	e2:SetOperation(c20320012.thop)
	c:RegisterEffect(e2)
end
function c20320012.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsAbleToGrave()
end
function c20320012.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320012.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c20320012.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20320012.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,nil,REASON_EFFECT)
	end
end