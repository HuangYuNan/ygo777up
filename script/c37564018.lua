--元素的圣域
function c37564018.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564018,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,375640181)
	e1:SetCondition(c37564018.spcon)
	e1:SetTarget(c37564018.target)
	e1:SetOperation(c37564018.operation)
	c:RegisterEffect(e1)
	-- 添加素材
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564018,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,375640181)
	e2:SetTarget(c37564018.target1)
	e2:SetOperation(c37564018.operation1)
	c:RegisterEffect(e2)	
	--本家以外破坏
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c37564018.descon)
	e3:SetTarget(c37564018.sptg)
	e3:SetOperation(c37564018.spop)
	c:RegisterEffect(e3)
end
function c37564018.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c37564018.filter(c)
	return c:IsSetCard(0x770) and c:IsType(TYPE_MONSTER) and c:GetLevel()==4
end
function c37564018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564018.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c37564018.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564018.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c37564018.filter1(c)
	return c:IsSetCard(0x771) 
end
function c37564018.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x770) and c:GetRank()==4
end
function c37564018.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c37564018.filter2,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingMatchingCard(c37564018.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c37564018.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c37564018.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e)then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(tp,c37564018.filter1,tp,LOCATION_DECK,0,1,1,nil)
		local mg=g:GetFirst()
		if g:GetCount()>0 then
		Duel.Overlay(tc,mg)
		end
	end
end
function c37564018.desfilter1(c,tp)
	return c:IsPreviousLocation(LOCATION_EXTRA) and c:GetSummonPlayer()==tp and not c:IsSetCard(0x770)
end
function c37564018.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c37564018.desfilter1,1,nil,tp) and e:GetHandler():IsStatus(STATUS_ACTIVATED)
end
function c37564018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
end
function c37564018.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end