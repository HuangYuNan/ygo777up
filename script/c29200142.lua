--凋叶棕-rebellion 
function c29200142.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x53e0),aux.NonTuner(Card.IsSetCard,0x53e0),1)
	c:EnableReviveLimit()
	--damage conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c29200142.rev)
	c:RegisterEffect(e2)
	--damage conversion
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_REVERSE_RECOVER)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--destroy replace
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e14:SetCode(EFFECT_DESTROY_REPLACE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetTarget(c29200142.reptg)
	c:RegisterEffect(e14)
end
function c29200142.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
function c29200142.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return e:GetHandler():IsReason(REASON_EFFECT+REASON_BATTLE) and c:GetDEFENSE()~=0 end
	if Duel.SelectYesNo(tp,aux.Stringid(29200142,0)) then
	local preatk=c:GetAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	if predef~=0 and c:GetDEFENSE()==0 then 
	   Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
		return true
	else return false end
end
