--剛毅な漁師サンディエゴ
function c9990315.initial_effect(c)
	--Synchro
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Battle Destruction
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c9990315.value)
	c:RegisterEffect(e1)
	--Exile
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c9990315.operation)
	c:RegisterEffect(e2)
end
function c9990315.value(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c9990315.costfilter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function c9990315.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not tc or tc:GetControler()==tp or not tc:IsAbleToRemove() then return end
	local mg=Duel.GetMatchingGroup(c9990315.costfilter,tp,LOCATION_GRAVE,0,nil)
	if mg:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(9990315,0)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=mg:Select(tp,1,1,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	Duel.HintSelection(Group.FromCards(tc))
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetLabelObject(tc)
	e1:SetOperation(c9990315.exile)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c9990315.exile(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end