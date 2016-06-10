--六芒星辉
function c66666616.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c66666616.spcost)
	e1:SetTarget(c66666616.sptg)
	e1:SetOperation(c66666616.spop)
	c:RegisterEffect(e1)
	if not c66666616.global_check then
		c66666616.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c66666616.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c66666616.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c66666616.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x661) then
			c66666616[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c66666616.clear(e,tp,eg,ep,ev,re,r,rp)
	c66666616[0]=true
	c66666616[1]=true
end
function c66666616.costfilter(c)
	return c:IsSetCard(0x661) and c:IsAbleToRemoveAsCost()
end
function c66666616.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66666616.costfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	local rt=Duel.GetTargetCount(Card.IsAbleToHand,tp,LOCATION_REMOVED,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,c66666616.costfilter,tp,LOCATION_GRAVE,0,1,rt,nil)
	Duel.Remove(cg,REASON_COST)
	e:SetLabel(cg:GetCount())
end
function c66666616.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x661) and c:IsRace(RACE_SPELLCASTER) and not c:IsType(TYPE_XYZ)
end
function c66666616.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66666616.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66666616.filter,tp,LOCATION_MZONE,0,1,nil) end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c66666616.filter,tp,LOCATION_MZONE,0,1,ct,nil)
end
function c66666616.spop(e,tp,eg,ep,ev,re,r,rp)
	local lc=e:GetLabelObject()
	if not lc:IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc do
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(6)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
