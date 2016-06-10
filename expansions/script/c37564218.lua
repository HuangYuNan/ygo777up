--千年的疾走梦   
function c37564218.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c37564218.activate)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(37564218,0))
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c37564218.remcon)
	e2:SetTarget(c37564218.remtg)
	e2:SetOperation(c37564218.remop)
	c:RegisterEffect(e2)
end
function c37564218.remfilter(c)
	return c:IsAbleToRemove() and c:IsFacedown()
end
function c37564218.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.IsExistingMatchingCard(c37564218.remfilter,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsExistingMatchingCard(c37564218.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(37564218,1)) then
		c37564218.remop(e,tp,eg,ep,ev,re,r,rp)
		e:GetHandler():RegisterFlagEffect(37564218,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(37564218,2))
	end
end
function c37564218.cfilter(c)
	return c:IsSetCard(0x773) and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE))
end
function c37564218.remcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c37564218.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
end
function c37564218.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(37564218)==0
		and Duel.IsExistingMatchingCard(c37564218.remfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_EXTRA)
	e:GetHandler():RegisterFlagEffect(37564218,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c37564218.remop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c37564218.remfilter,tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,1)
		e1:SetCountLimit(1)
		e1:SetLabel(c37564218.counter)
		e1:SetCondition(c37564218.retcon)
		e1:SetOperation(c37564218.retop)
		e1:SetLabelObject(g)
		Duel.RegisterEffect(e1,tp)
		g:KeepAlive()
		local tc=g:GetFirst()
		while tc do
			tc:RegisterFlagEffect(37564218,RESET_EVENT+0x1fe0000,0,1)
			tc=g:GetNext()
		end
	end
end
function c37564218.retfilter(c)
	return c:GetFlagEffect(37564218)~=0
end
function c37564218.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c37564218.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c37564218.retfilter,nil)
	g:DeleteGroup()
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)
	end
end
