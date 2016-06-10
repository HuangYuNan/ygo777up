--小鸟游十花
function c20152209.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x3290),1)
	c:EnableReviveLimit()
--recover
	local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(20152209,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_QUICK_O	)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c20152209.cost)
	e1:SetTarget(c20152209.target)
	e1:SetOperation(c20152209.operation)
	c:RegisterEffect(e1)
		--synchro effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152209,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20152209.sccon)
	e2:SetTarget(c20152209.sctarg)
	e2:SetOperation(c20152209.scop)
	c:RegisterEffect(e2)
end
function c20152209.costfilter(c)
	return c:IsSetCard(0x3290)
end
function c20152209.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c20152209.costfilter,1,nil) end
	local sg=Duel.SelectReleaseGroupEx(tp,c20152209.costfilter,1,1,nil)
	local tc=sg:GetFirst()
	local atk=tc:GetAttack()
	local def=tc:GetDefense()
	Duel.Release(tc,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20152209,0))
	local sel=Duel.SelectOption(tp,aux.Stringid(20152209,1),aux.Stringid(20152209,2))
	if sel==0 then e:SetLabel(atk)
	else e:SetLabel(def) end
end
function c20152209.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabel())
end
function c20152209.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c20152209.sccon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c20152209.sctarg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c20152209.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetControler()~=tp or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),c)
	end
end
