--背愿之巫女·小忆·午夜
function c10956108.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(c10956108.sfilter),1)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.synlimit)
	c:RegisterEffect(e0)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10956108,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c10956108.con)
	e2:SetTarget(c10956108.target)
	e2:SetOperation(c10956108.activate)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c10956108.value)
	c:RegisterEffect(e3)   
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c10956108.disable)
	e4:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c10956108.disable(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT) and c:IsDefensePos()
end
function c10956108.sfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsType(TYPE_SYNCHRO)
end
function c10956108.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x23d)
end
function c10956108.value(e,c)
	return Duel.GetMatchingGroupCount(c10956108.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*-1000
end
function c10956108.con(e)
	return e:GetHandler():GetAttack()==0
end
function c10956108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,LOCATION_GRAVE)*200
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c10956108.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,LOCATION_GRAVE)*200
	Duel.Damage(p,dam,REASON_EFFECT)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	if Duel.SendtoDeck(g,nil,0,REASON_EFFECT)~=0 then
		Duel.ShuffleDeck(tp)
	end
end