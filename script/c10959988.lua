--恶作剧的传送门
function c10959988.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10959988)
	e1:SetCondition(c10959988.condition)
	e1:SetTarget(c10959988.target)
	e1:SetOperation(c10959988.activate)
	c:RegisterEffect(e1)	
end
function c10959988.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()<1
end
function c10959988.filter(c,tp)
	if not c:IsType(TYPE_FIELD) or c:IsForbidden() then return false end
	local te=c:GetActivateEffect()
	local con=te:GetCondition()
	if con and not con(te,tp,nil,0,0,nil,0,0) then return false end
	local cost=te:GetCost()
	if cost and not cost(te,tp,nil,0,0,nil,0,0,0) then return false end
	local tg=te:GetTarget()
	if tg and not tg(te,tp,nil,0,0,nil,0,0,0) then return false end
	return true
end
function c10959988.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10959988.filter,tp,LOCATION_DECK,0,1,nil,tp) and Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c10959988.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10959988,0))
	local tc=Duel.SelectMatchingCard(tp,c10959988.filter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,te,0,tp,tp,Duel.GetCurrentChain())
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end 
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
