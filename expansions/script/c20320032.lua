--×10 Big Rocket
function c20320032.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20320032.target)
	e1:SetOperation(c20320032.activate)
	c:RegisterEffect(e1)
end
function c20320032.ffilter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM)
end
function c20320032.dfilter(c,e,tp,d)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand() and c:IsAttackBelow(d*4)
end
function c20320032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20320032.ffilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local g=Duel.SelectTarget(tp,c20320032.ffilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	e:SetLabel(g:GetFirst():GetLevel()*100)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,e:GetLabel())
end
function c20320032.activate(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.Damage(1-tp,d,REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(c20320032.dfilter,tp,LOCATION_DECK,0,nil,e,tp,d)
		if g:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end