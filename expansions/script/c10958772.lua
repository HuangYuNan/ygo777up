--创世之巫女·茧
function c10958772.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,5,c10958772.ovfilter,aux.Stringid(10958772,0))
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c10958772.splimit)
	c:RegisterEffect(e0)
	--charge
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10958772,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c10958772.matg)
	e1:SetOperation(c10958772.mtop)
	c:RegisterEffect(e1) 
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10958772,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c10958772.thcost)
	e2:SetOperation(c10958772.sumsuc)
	c:RegisterEffect(e2)   
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c10958772.efilter)
	c:RegisterEffect(e3)
	--turn skip
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10958772,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetCountLimit(1,10958772+EFFECT_COUNT_CODE_DUEL)
	e4:SetCost(c10958772.skipcost)
	e4:SetCondition(c10958772.spcon2)
	e4:SetTarget(c10958772.skiptg)
	e4:SetOperation(c10958772.skipop)
	c:RegisterEffect(e4)
end
function c10958772.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ and not (se:GetHandler():IsType(TYPE_SPELL) or se:GetHandler():IsType(TYPE_MONSTER) or se:GetHandler():IsType(TYPE_TRAP))
end 
function c10958772.ovfilter(c)
	return (c:IsSetCard(0x23a) or c:IsCode(10958774)) and c:IsType(TYPE_XYZ)
end
function c10958772.matg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_EXTRA,0,1,nil) end
end
function c10958772.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_EXTRA,0,10,10,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c10958772.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c10958772.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c10958772.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c10958772.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetTargetRange(0,LOCATION_ONFIELD)
	e2:SetTarget(c10958772.disable)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c10958772.aclimit(e,re,tp)
	return re:GetHandler():IsOnField() and e:GetHandler()~=re:GetHandler()
end
function c10958772.disable(e,c)
	return c~=e:GetHandler() and (not c:IsType(TYPE_MONSTER) or (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT))
end
function c10958772.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c10958772.skipcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,5,REASON_COST) end
	c:RemoveOverlayCard(tp,5,5,REASON_COST)
end
function c10958772.filter(c)
	return c:IsAbleToRemove()
end
function c10958772.skiptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10958772.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
	and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_SKIP_TURN) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c10958772.skipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SelectOption(tp,aux.Stringid(10958772,3))
	local g=Duel.GetMatchingGroup(c10958772.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e1:SetCondition(c10958772.skipcon)
	Duel.RegisterEffect(e1,tp)
end
function c10958772.skipcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end