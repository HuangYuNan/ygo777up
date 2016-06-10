--元素精灵·坡库鲁
function c37564008.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(1,37564008)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c37564008.sptg)
	e1:SetOperation(c37564008.spop)
	c:RegisterEffect(e1)
	  local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c37564008.filter(c,e,tp)
	return c:GetRank()==4 and c:IsSetCard(0x770) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564008.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c17412721.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c37564008.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c37564008.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c37564008.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and  Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		 local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		 e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetCondition(c37564008.discon)
		e1:SetValue(c37564008.xyzlv)
		e1:SetReset(0)
		tc:RegisterEffect(e1)
		end	
end
function c37564008.xyzlv(e,c,rc)
	return c:GetRank()
end
function c37564008.cfilter(c)
	return c:IsFaceup() and c:IsCode(37564008)
end
function c37564008.discon(e)
	if Duel.IsExistingMatchingCard(c37564008.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil) then
		return true
	end
	e:Reset()
	return false
end