--悠久的使者·莎榭·新月
function c10952401.initial_effect(c)
	--xyzlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c10952401.xyzlimit)
	c:RegisterEffect(e3)
	--act limit
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EFFECT_CANNOT_ACTIVATE)
	e8:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e8:SetTargetRange(1,0)
	e8:SetValue(c10952401.aclimit)
	c:RegisterEffect(e8)
	--splimit
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e9:SetTargetRange(1,0)
	e9:SetTarget(c10952401.splimit)
	c:RegisterEffect(e9)
end
function c10952401.aclimit(e,re,tp)
	return re:GetHandler():GetType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c10952401.splimit(e,c,tp,sumtp,sumpos)
	return c:GetRank()==4
end
function c10952401.xyzlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_FAIRY)
end