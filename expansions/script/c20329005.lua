--滑膛火炮 卡尔臼炮
function c20329005.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,3,c20329005.ovfilter,aux.Stringid(20329005,0))
	c:EnableReviveLimit()
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20329005,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,20329005)
	e1:SetCondition(c20329005.con)
	e1:SetCost(c20329005.cost)
	e1:SetOperation(c20329005.op)
	c:RegisterEffect(e1)
end
function c20329005.ovfilter(c)
	local lv=c:GetLevel()
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and lv==10
end
function c20329005.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c20329005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20329005.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lp1=Duel.GetLP(tp)
	local lp2=Duel.GetLP(1-tp)
	if lp1==lp2 then return end
	if lp1>lp2 then 
		Duel.Damage(1-tp,lp1-lp2,REASON_EFFECT)
		Duel.BreakEffect()
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(lp1-lp2)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e2)
		end
	elseif lp1<lp2 then
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(lp2-lp1)
			c:RegisterEffect(e1)
		end
	end
end