--永恒的元素·Miracle·Virtue
function c10954777.initial_effect(c)
	c:EnableReviveLimit()
	--synchro summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10954777,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(aux.SynCondition(aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),aux.NonTuner(Card.IsRace,RACE_FAIRY),1,99))
	e1:SetTarget(aux.SynTarget(aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),aux.NonTuner(Card.IsRace,RACE_FAIRY),1,99))
	e1:SetOperation(aux.SynOperation(aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),aux.NonTuner(Card.IsRace,RACE_FAIRY),1,99))
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(10954777,1))
	e2:SetCondition(c10954777.syncon)
	e2:SetTarget(c10954777.syntg)
	e2:SetOperation(c10954777.synop)
	e2:SetValue(SUMMON_TYPE_SYNCHRO+0x10)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10954777.discon)
	e3:SetTarget(c10954777.distg)
	e3:SetOperation(c10954777.disop)
	c:RegisterEffect(e3)
	--cannot target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetCondition(c10954777.excon)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetCondition(c10954777.excon)
	e5:SetValue(c10954777.efilter)
	c:RegisterEffect(e5)
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10954777,2))
	e6:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c10954777.excon)
	e6:SetTarget(c10954777.sptg2)
	e6:SetOperation(c10954777.spop2)
	c:RegisterEffect(e6)   
end
function c10954777.matfilter1(c,syncard)
	return c:IsSetCard(0x239) and c:IsNotTuner() and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c10954777.matfilter2(c,syncard)
	return c:IsSetCard(0x239) and c:IsNotTuner() and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c10954777.synfilter(c,syncard,lv,g2)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	return g2:CheckWithSumEqual(Card.GetSynchroLevel,lv-tlv,1,63,syncard)
end
function c10954777.syncon(e,c,tuner,mg)
	if c==nil then return true end
	if c:IsSetCard(0x239) and c:IsFaceup() then return false end
	local tp=c:GetControler()
	local minct=2
	local g1=nil
	local g2=nil
	if mg then
		g1=mg:Filter(c10954777.matfilter1,nil,c)
		g2=mg:Filter(c10954777.matfilter2,nil,c)
	else
		g1=Duel.GetMatchingGroup(c10954777.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c10954777.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		local tlv=tuner:GetSynchroLevel(c)
		if lv-tlv<=0 then return false end
		return g2:CheckWithSumEqual(Card.GetSynchroLevel,lv-tlv,1,63,c)
	end
	if not pe then
		return g1:IsExists(c10954777.synfilter,1,nil,c,lv,g2)
	else
		return c10954777.synfilter(pe:GetOwner(),c,lv,g2)
	end
end
function c10954777.syntg(e,tp,eg,ep,ev,re,r,rp,chk,c,tuner,mg)
	local g=Group.CreateGroup()
	local g1=nil
	local g2=nil
	if mg then
		g1=mg:Filter(c10954777.matfilter1,nil,c)
		g2=mg:Filter(c10954777.matfilter2,nil,c)
	else
		g1=Duel.GetMatchingGroup(c10954777.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c10954777.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		g:AddCard(tuner)
		local lv1=tuner:GetSynchroLevel(c)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m2=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1,1,63,c)
		g:Merge(m2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner=nil
		if not pe then
			local t1=g1:FilterSelect(tp,c10954777.synfilter,1,1,nil,c,lv,g2)
			tuner=t1:GetFirst()
		else
			tuner=pe:GetOwner()
			Group.FromCards(tuner):Select(tp,1,1,nil)
		end
		g:AddCard(tuner)
		local lv1=tuner:GetSynchroLevel(c)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m2=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1,1,63,c)
		g:Merge(m2)
	end
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	else return false end
end
function c10954777.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner,mg)
	local g=e:GetLabelObject()
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
	g:DeleteGroup()
end
function c10954777.discon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return (loc==LOCATION_HAND or loc==LOCATION_GRAVE) and Duel.IsChainNegatable(ev)
end
function c10954777.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c10954777.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c10954777.cfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsRankAbove(4)
end
function c10954777.excon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10954777.cfilter,0,LOCATION_GRAVE,0,5,nil)
end
function c10954777.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTORY,nil,1,tp,LOCATION_DECK)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10954777.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c10954777.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
