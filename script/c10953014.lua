--花物语·忧郁之爱·黑郁金香
function c10953014.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c10953014.condition1)
	e1:SetTarget(c10953014.target)
	e1:SetOperation(c10953014.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCondition(c10953014.condition2)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCondition(c10953014.condition3)
	c:RegisterEffect(e3)
	--act in set turn
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCountLimit(1,10953014)
	c:RegisterEffect(e4)
end
function c10953014.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c10953014.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0 and Duel.IsExistingMatchingCard(c10953014.filter,tp,LOCATION_MZONE,0,1,nil)
	and re:GetHandler():IsType(TYPE_COUNTER) or re:GetHandler():IsType(TYPE_EQUIP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c10953014.condition2(e,tp,eg,ep,ev,re,r,rp)
	if (not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE))
	or not Duel.IsChainNegatable(ev) then return false end 
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>1 and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0 and Duel.IsExistingMatchingCard(c10953014.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c10953014.condition3(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end 
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField() and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0 and Duel.IsExistingMatchingCard(c10953014.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c10953014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10953014.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=Duel.GetCurrentChain()
	if ct>2 then
		c:CancelToGrave()
		Duel.ChangePosition(c,POS_FACEDOWN)
		Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	elseif ct>1 then
		c:CancelToGrave()
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end