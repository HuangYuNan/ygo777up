--落雷
function c23400008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23400008+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c23400008.cost)
	e1:SetTarget(c23400008.sptg)
	e1:SetOperation(c23400008.spop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23400008,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c23400008.negcon)
	e2:SetCost(c23400008.negcost)
	e2:SetTarget(c23400008.negtg)
	e2:SetOperation(c23400008.negop)
	c:RegisterEffect(e2)
end
function c23400008.cfilter(c)
	return c:IsSetCard(0x530) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c23400008.negcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) and Duel.IsExistingMatchingCard(c23400008.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c23400008.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c23400008.negfilter(c)
	return aux.disfilter1(c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c23400008.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c23400008.negfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23400008.negfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c23400008.negfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function c23400008.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			tc:RegisterEffect(e3)
		end
	end
end

------
function c23400008.rfilter(c,e,tp)
	local lv=c:GetCode()
	return  c:IsSetCard(0x530) and c:IsReleasable()
		and Duel.IsExistingMatchingCard(c23400008.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,lv)
end
function c23400008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c23400008.rfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,c23400008.rfilter,1,1,nil,e,tp)
	local tc=g:GetFirst()
	e:SetLabel(tc:GetCode())
	Duel.Release(g,REASON_COST)
end
function c23400008.spfilter(c,e,tp,lv)
	return c:GetCode()~=lv and c:IsSetCard(0x530) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23400008.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23400008.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23400008.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,lv)
	local tc=g:GetFirst()
	if tc and
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	 then tc:EnableDualState()
	end
end