--藏书屋·博丽灵梦
function c60024.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(60024,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,60024)
	e2:SetTarget(c60024.sptg)
	e2:SetOperation(c60024.spop)
	c:RegisterEffect(e2)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c60024.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c60024.limit)
	c:RegisterEffect(e7)
	--CONTROL
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,60024)
	e4:SetTarget(c60024.target)
	e4:SetOperation(c60024.operation)
	c:RegisterEffect(e4)
end
function c60024.matfilter(c)
	return c:IsSetCard(0x300) and c:IsType(TYPE_RITUAL+TYPE_SYNCHRO) and c:IsAbleToGrave()
end
function c60024.valsiezer(c,e)
	if bit.band(c:GetOriginalType(),TYPE_XYZ)~=0 then
		return c:GetRank()
	else
		return c:GetRitualLevel(e:GetHandler())
	end
end
function c60024.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local m=Duel.GetMatchingGroup(c60024.matfilter,tp,LOCATION_MZONE,0,nil)
		if c.mat_filter then
			m=m:Filter(c.mat_filter,nil)
		end
		return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,true) and m:CheckWithSumGreater(c60024.valsiezer,c:GetOriginalLevel(),e)
	end 
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c60024.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local mg=Duel.GetMatchingGroup(c60024.matfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local mat=mg:SelectWithSumGreater(tp,c60024.valsiezer,c:GetOriginalLevel(),e)
	c:SetMaterial(mat)
	Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
	Duel.BreakEffect()
	Duel.SpecialSummon(c,SUMMON_TYPE_RITUAL,tp,tp,true,true,POS_FACEUP)
	c:CompleteProcedure()
end
function c60024.limit(e,c)
	if not c then return false end
	return not (c:IsSetCard(0x300) or c:IsSetCard(0xa78))
end
function c60024.filter(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup() and (c:IsAttribute(ATTRIBUTE_EARTH) or
		c:IsRace(RACE_SPELLCASTER))
end
function c60024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c60024.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60024.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c60024.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c60024.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not Duel.GetControl(tc,tp,PHASE_END,1) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end