--DRRR!! 甘乐
function c80003038.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,80003038)
	aux.AddFusionProcCodeFun(c,80003034,aux.FilterBoolFunction(Card.IsSetCard,0x2da),1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1) 
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80003038,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c80003038.sccon)
	e2:SetTarget(c80003038.rmtg)
	e2:SetOperation(c80003038.rmop)
	c:RegisterEffect(e2)   
	--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80003038,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)  
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c80003038.condition)
	e3:SetTarget(c80003038.target)
	e3:SetOperation(c80003038.operation)
	c:RegisterEffect(e3)   
end
function c80003038.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION 
end
function c80003038.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c80003038.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,0,LOCATION_HAND,nil)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
end
function c80003038.rmfilter(c)
	return c:IsAbleToRemove() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL 
end
function c80003038.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c80003038.rmfilter(chkc) end
	if chk==0 then return e:GetHandler():IsAbleToRemove()
		and Duel.IsExistingTarget(c80003038.rmfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c80003038.rmfilter,tp,0,LOCATION_MZONE,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c80003038.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local g=Group.FromCards(c,tc)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local fid=c:GetFieldID()
		local rct=1
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then rct=2 end
		local og=Duel.GetOperatedGroup()
		local oc=og:GetFirst()
		while oc do
			if oc:IsControler(tp) then
				oc:RegisterFlagEffect(80003038,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,rct,fid)
			else
				oc:RegisterFlagEffect(80003038,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,0,1,fid)
			end
			oc=og:GetNext()
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(og)
		e1:SetCondition(c80003038.retcon)
		e1:SetOperation(c80003038.retop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
			e1:SetValue(Duel.GetTurnCount())
		else
			e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
			e1:SetValue(0)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c80003038.retfilter(c,fid)
	return c:GetFlagEffectLabel(80003038)==fid
end
function c80003038.retcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp or Duel.GetTurnCount()==e:GetValue() then return false end
	local g=e:GetLabelObject()
	if not g:IsExists(c80003038.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c80003038.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c80003038.retfilter,nil,e:GetLabel())
	g:DeleteGroup()
	local tc=sg:GetFirst()
	while tc do
		Duel.ReturnToField(tc)
		tc=sg:GetNext()
	end
end
function c80003038.sccon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end