--Eldrazi Skyspawner
require "expansions/script/c9990000"
function c9991120.initial_effect(c)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--Spawn Scion
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>0
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Dazz.IsCanCreateEldraziScion(tp) end
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
		if not Dazz.IsCanCreateEldraziScion(tp) then return end
		local token=Dazz.CreateEldraziScion(e,tp)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end)
	c:RegisterEffect(e1)
end