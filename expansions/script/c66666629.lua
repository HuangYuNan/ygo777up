--黑之月的后继者-音色
function c66666629.initial_effect(c)
	c:SetUniqueOnField(1,0,66666629)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),6,2)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66666629,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66666629.xyzcondition)
	e1:SetOperation(c66666629.xyzoperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66666629.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c66666629.rmcost)
	e3:SetTarget(c66666629.rmtg)
	e3:SetOperation(c66666629.rmop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCost(c66666629.spcost)
	e4:SetTarget(c66666629.sptg)
	e4:SetOperation(c66666629.spop)
	c:RegisterEffect(e4)
end
function c66666629.xyzfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x661) and c:IsRace(RACE_SPELLCASTER) and not c:IsType(TYPE_XYZ)
end
function c66666629.xyzcondition(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c66666629.xyzfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and mg:GetCount()>=2
end
function c66666629.xyzoperation(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mg=Duel.GetMatchingGroup(c66666629.xyzfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=mg:Select(tp,2,2,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsType(TYPE_XYZ) then
			local sg=tc:GetOverlayGroup()
			if sg:GetCount()>0 then
				Duel.SendtoGrave(sg,REASON_RULE)
			end
		end
		tc=g:GetNext()
	end
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c66666629.indcon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c66666629.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66666629.tgfilter(c)
	return c:IsAbleToRemove()
end
function c66666629.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c66666629.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c66666629.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c66666629.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c66666629.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c66666629.spfilter(c,e,tp)
	return c:IsSetCard(0x661) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(4)
end
function c66666629.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c66666629.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c66666629.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666629.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(6)
		tc:RegisterEffect(e1,true)
end