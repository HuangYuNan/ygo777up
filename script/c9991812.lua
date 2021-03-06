--Megantic Sliver
require "expansions/script/c9990000"
function c9991812.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Power Up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c) return Dazz.IsSliver(c) end)
	e1:SetValue(600)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetRange(LOCATION_EXTRA)
	e3:SetValue(300)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
c9991812.Dazz_name_sliver=true