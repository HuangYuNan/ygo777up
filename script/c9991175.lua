--Crumble to Dust
function c9991175.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c9991175.target)
	e1:SetOperation(c9991175.activate)
	c:RegisterEffect(e1)
end
function c9991175.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c9991175.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c9991175.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>1
		and Duel.IsExistingTarget(c9991175.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c9991175.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c9991175.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>1 then
		local tc=Duel.GetFirstTarget()
		if not tc:IsRelateToEffect(e) then return end
		Duel.SendtoGrave(tc,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(function(c,code)
			return c:IsAbleToRemove() and c:IsCode(code)
				and (not c:IsLocation(LOCATION_EXTRA) or c:IsFaceup())
		end,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_HAND+LOCATION_EXTRA,nil,tc:GetCode())
		if g:GetCount()~=0 then Duel.Remove(g,POS_FACEUP,REASON_EFFECT) end
		local cg1=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
		local cg2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		if cg1:GetCount()~=0 then
			Duel.ConfirmCards(tp,cg1)
		end
		if cg2:GetCount()~=0 then
			Duel.ConfirmCards(tp,cg2)
			Duel.ShuffleHand(1-tp)
		end
	end
end