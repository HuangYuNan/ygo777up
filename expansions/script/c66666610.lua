--星之华的御魂者-羽弥
function c66666610.initial_effect(c)
	c:SetUniqueOnField(1,0,66666610)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetCondition(c66666610.remcon)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66666610,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetTarget(c66666610.atktg)
	e2:SetOperation(c66666610.atkop)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66666610,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c66666610.spcost)
	e3:SetTarget(c66666610.sptg)
	e3:SetOperation(c66666610.spop)
	c:RegisterEffect(e3)
	--Special Summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(66666610,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c66666610.xyzcon)
	e4:SetCost(c66666610.xyzcost)
	e4:SetTarget(c66666610.xyztg)
	e4:SetOperation(c66666610.xyzop)
	c:RegisterEffect(e4)
end
function c66666610.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonLocation()==LOCATION_DECK
end
function c66666610.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x661)
end
function c66666610.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c66666610.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66666610.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c66666610.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c66666610.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(600)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c66666610.efilter)
		tc:RegisterEffect(e2)
	end
end
function c66666610.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c66666610.cfilter(c)
	return c:IsSetCard(0x661) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c66666610.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66666610.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c66666610.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c66666610.spfilter(c,e,tp)
	return c:IsCode(66666611) and e:GetHandler():IsCanBeXyzMaterial(c) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c66666610.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsExistingMatchingCard(c66666610.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c66666610.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666610.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c66666610.filter(c)
	return c:IsFaceup() and c:IsCode(66666611)
end
function c66666610.xyzcon(e,tp)
	return Duel.IsExistingMatchingCard(c66666610.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c66666610.xyzcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c66666610.xyzfilter1(c,e,tp)
	return c:IsSetCard(0x661) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ) and Duel.IsExistingMatchingCard(c66666610.xyzfilter2,tp,LOCATION_EXTRA,0,2,nil,e,tp)
end
function c66666610.xyzfilter2(c,e,tp)
	return c:IsCode(66666612) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c66666610.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c66666610.xyzfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1   and Duel.IsExistingTarget(c66666610.xyzfilter1,tp,LOCATION_ONFIELD,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c66666610.xyzfilter1,tp,LOCATION_ONFIELD,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c66666610.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66666610.xyzfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
		Duel.Overlay(sc,sg)
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
