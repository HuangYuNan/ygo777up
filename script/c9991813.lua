--Bonescythe Sliver
require "expansions/script/c9990000"
function c9991813.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Multiple Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c) return Dazz.IsSliver(c) end)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetTarget(c9991813.con1)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTarget(c9991813.con2)
	c:RegisterEffect(e3)
end
c9991813.Dazz_name_sliver=true
function c9991813.con1(e,c)
	return Dazz.IsSliver(c) and c:GetAttackAnnouncedCount()>0
end
function c9991813.con2(e,c)
	return Dazz.IsSliver(c) and c:IsDirectAttacked()
end