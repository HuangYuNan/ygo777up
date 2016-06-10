--百慕 神秘微笑·亚拉璐  
require "script/c37564765"
function c37564405.initial_effect(c)
	senya.bm(c,c37564405.sptg,c37564405.spop,false,CATEGORY_SPECIAL_SUMMON)
	Duel.AddCustomActivityCounter(37564405,ACTIVITY_SPSUMMON,c37564405.counterfilter)
end
function c37564405.counterfilter(c)
	return c:IsSetCard(0x775)
end
function c37564405.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x775)
end
function c37564405.filter(c,e,tp)
	return senya.bmchkfilter(c) and not c:IsCode(37564405) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564405.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564405.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetCustomActivityCount(37564405,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c37564405.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c37564405.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564405.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
			local tc=g:GetFirst()
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_TO_HAND)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
		end
	end
end