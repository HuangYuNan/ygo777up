--战场女武神 塞露贝利亚 瓦尔基里
function c11113004.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113004,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,11113004)
	e2:SetCost(c11113004.spcost)
	e2:SetTarget(c11113004.sptg)
	e2:SetOperation(c11113004.spop)
	c:RegisterEffect(e2)
	--Negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113004,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,111130040)
	e3:SetCondition(c11113004.negcon)
	e3:SetCost(c11113004.negcost)
	e3:SetTarget(c11113004.negtg)
	e3:SetOperation(c11113004.negop)
	c:RegisterEffect(e3)
	--index
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11113004,2))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,1111300400)
	e4:SetCost(c11113004.indcost)
	e4:SetTarget(c11113004.indtg)
	e4:SetOperation(c11113004.indop)
	c:RegisterEffect(e4)
end
function c11113004.mat_filter(c)
	return c:GetLevel()~=8
end
function c11113004.spfilter1(c,tp)
	return c:IsFaceup() and c:IsCode(11113013) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c11113004.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c11113004.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:GetLevel()==4 and c:IsAbleToRemoveAsCost()
end
function c11113004.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113004.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c11113004.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c11113004.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c11113004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11113004.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
	end
end
function c11113004.negcon(e,tp,eg,ep,ev,re,r,rp)
    local rc=re:GetHandler()
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsActiveType(TYPE_MONSTER)
		and rc:GetSummonLocation()==LOCATION_EXTRA and loc==LOCATION_MZONE
		and ep~=tp and Duel.IsChainNegatable(ev)
end
function c11113004.dfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsAbleToDeckAsCost()
end	
function c11113004.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113004.dfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c11113004.dfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c11113004.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local rc=re:GetHandler()
	if rc:IsRelateToEffect(re) and rc:IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c11113004.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c11113004.indcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c11113004.infilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and bit.band(c:GetType(),0x81)==0x81
end
function c11113004.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c11113004.infilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113004.infilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c11113004.infilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c11113004.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(c11113004.efilter)
		tc:RegisterEffect(e1)
	end
end
function c11113004.efilter(e,te)
	if te:IsActiveType(TYPE_MONSTER) and (te:IsHasType(0x7e0) or te:IsHasProperty(EFFECT_FLAG_FIELD_ONLY) or te:IsHasProperty(EFFECT_FLAG_OWNER_RELATE)) then
		local lv=e:GetHandler():GetLevel()
		local ec=te:GetOwner()
		if ec:IsType(TYPE_XYZ) then
			return ec:GetOriginalRank()<lv
		else
			return ec:GetOriginalLevel()<lv
		end
	end
	return false
end