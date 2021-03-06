--Vile Aggregate
require "expansions/script/c9990000"
function c9991134.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Trample
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c) return c9991134.tgfilter(c) end)
	c:RegisterEffect(e1)
	--Attack Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(function(e,c)
		return Duel.GetMatchingGroupCount(c9991134.tgfilter,c:GetControler(),LOCATION_MZONE,0,nil)*500
	end)
	c:RegisterEffect(e2)
	--Crave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local tc=eg:GetFirst()
		return ep~=tp and tc:IsControler(tp) and c9991134.tgfilter(tc)
	end)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(1-tp,1)
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e3)
end
function c9991134.tgfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_REPTILE)
end