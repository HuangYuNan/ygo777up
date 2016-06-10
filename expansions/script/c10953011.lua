--花妖精·曼陀罗
function c10953011.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_PLANT),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--synchro summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10953011,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,10953011)
	e1:SetCondition(c10953011.drcon)
	e1:SetTarget(c10953011.drtarg)
	e1:SetOperation(c10953011.drop)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	e2:SetValue(-1)
	c:RegisterEffect(e2)
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetCondition(c10953011.recon)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)
end
function c10953011.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)>=6
		and Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0
end
function c10953011.drtarg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c10953011.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c10953011.recon(e)
	return e:GetHandler():IsFaceup()
end