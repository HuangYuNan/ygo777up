--�����ػ�Ů��  ��ɫŮ��next
function c1101140.initial_effect(c)
	c:SetUniqueOnField(1,0,1101140)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),6,3)
	c:EnableReviveLimit()
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetTarget(c1101140.target)
	e2:SetOperation(c1101140.operation)
	c:RegisterEffect(e2)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c1101140.aclimit)
	e2:SetCondition(c1101140.actcon)
	c:RegisterEffect(e2)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c1101140.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c1101140.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c1101140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and not bc:IsType(TYPE_TOKEN)
end
function c1101140.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToBattle() and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c1101140.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,nil,TYPE_MONSTER)*200
end
function c1101140.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c1101140.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end