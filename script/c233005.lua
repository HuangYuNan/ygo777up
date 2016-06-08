--极夜的魔女 莉莉丝
function c233005.initial_effect(c)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(233005,0))
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c233005.spcon)
	e3:SetOperation(c233005.spop)
	e3:SetLabel(ATTRIBUTE_LIGHT)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetDescription(aux.Stringid(233005,1))
	e4:SetLabel(ATTRIBUTE_DARK)
	c:RegisterEffect(e4)
	--limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(0,1)
	e5:SetTarget(c233005.sumlimit)
	c:RegisterEffect(e5)
	e3:SetLabelObject(e5)
	e4:SetLabelObject(e5)
end
function c233005.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	if e:GetLabel()==ATTRIBUTE_LIGHT then
	return c:IsLocation(LOCATION_HAND)
	elseif e:GetLabel()==ATTRIBUTE_DARK then
	return c:IsLocation(LOCATION_GRAVE) end
end
function c233005.spcon(e,c)
	return Duel.GetMatchingGroupCount(c233005.spfilter,tp,LOCATION_GRAVE,0,nil,e:GetLabel())>0
end
function c233005.spfilter(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost() --and c:IsRace(0x2)
end
function c233005.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectMatchingCard(tp,c233005.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e:GetLabel())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:GetLabelObject():SetLabel(e:GetLabel())
end