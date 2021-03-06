--Void Winnower
function c9991124.initial_effect(c)
	--Tribute Limit
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetCode(EFFECT_TRIBUTE_LIMIT)
	ex:SetValue(function(e,c)
		return not c:IsRace(RACE_REPTILE) or not c:IsAttribute(ATTRIBUTE_LIGHT)
	end)
	c:RegisterEffect(ex)
	local ex2=Effect.CreateEffect(c)
	ex2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ex2:SetType(EFFECT_TYPE_SINGLE)
	ex2:SetCode(EFFECT_SPSUMMON_CONDITION)
	ex2:SetValue(aux.FALSE)
	c:RegisterEffect(ex2)
	--Summon Limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetTarget(function(e,c,tp,sumtp,sumpos)
		local param=math.max(c:GetLevel(),c:GetRank())
		return param%2==0
	end)
	c:RegisterEffect(e3)
	local e3b=e3:Clone()
	e3b:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e3b)
	--Activate Limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetValue(function(e,re,tp)
		local tc=re:GetHandler()
		if tc:IsImmuneToEffect(e) then return false end
		if not re:IsActiveType(TYPE_MONSTER) then return false end
		local param=math.max(tc:GetLevel(),tc:GetRank())
		return param%2==0
	end)
	c:RegisterEffect(e4)
end