--大火的终局
function c10950031.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCountLimit(1,10950031+EFFECT_COUNT_CODE_DUEL)
	e1:SetCost(c10950031.cost)
	e1:SetTarget(c10950031.tg)
	e1:SetOperation(c10950031.op)
	c:RegisterEffect(e1)
end
function c10950031.cfilter(c)
	return c:IsCode(10950012) and c:IsAbleToRemoveAsCost()
end
function c10950031.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10950031.cfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10950031.cfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c10950031.filter(c,e,tp)
	return c:IsSetCard(0x231) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10950031.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c10950031.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c10950031.op(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10950031.filter,tp,LOCATION_GRAVE,0,ft,ft,nil,e,tp)
	if g:GetCount()>0 then
		local fid=e:GetHandler():GetFieldID()
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(10950031,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetOperation(c10950031.lpop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(c10950031.aclimit)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	end
end
function c10950031.lpop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	Duel.SelectOption(tp,aux.Stringid(10950031,0))
	Duel.SelectOption(tp,aux.Stringid(10950031,1))
	Duel.SetLP(tp,0)
end
function c10950031.aclimit(e,re,tp)
	return re:GetHandler():IsCode(10950017) 
end