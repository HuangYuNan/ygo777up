--蚀神的月见天使 暗刻
function c2142007.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2142007,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c2142007.descost)
	e1:SetCountLimit(1)
	e1:SetTarget(c2142007.target)
	e1:SetOperation(c2142007.operation)
	c:RegisterEffect(e1)
end
function c2142007.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c2142007.ftarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c2142007.ftarget(e,c)
	return not c:IsSetCard(0x212)
end
function c2142007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2142007,1))
end
function c2142007.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	for i=1,8 do t[i]=i end
	local lv=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2142007,1))
	local c=e:GetHandler()
	local op=0
	op=Duel.SelectOption(tp,aux.Stringid(2142007,2),aux.Stringid(2142007,3))
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		if op==0 then
			e1:SetValue(lv)
		else e1:SetValue(-lv) end
		c:RegisterEffect(e1)
	end
	local tg=c:GetLevel()
	local mg=Duel.GetMatchingGroup(c2142007.matfilter,tp,0,LOCATION_MZONE,nil):GetSum(c2142007.getsum)
	if tg==mg then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		mat=Duel.GetMatchingGroup(c2142007.matfilter,tp,0,LOCATION_MZONE,nil)
		Duel.BreakEffect()
		Duel.SendtoGrave(mat,REASON_EFFECT)
	end
end
function c2142007.matfilter(c)
	return c:IsFaceup() and c:IsAbleToGrave() and c:IsType(TYPE_MONSTER)
end
function c2142007.getsum(c)
	if c:IsType(TYPE_XYZ) then
		return c:GetRank()
	else
		return c:GetLevel()
	end
end
