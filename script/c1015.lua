--人形「没有灵魂的集体舞」
function c1015.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1015+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c1015.target)
	e1:SetOperation(c1015.operation)
	c:RegisterEffect(e1)
end
function c1015.filter(c,e,tp)
	return c:IsSetCard(0x989) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c1015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
		and Duel.IsExistingMatchingCard(c1015.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c1015.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local ft3=ft1+ft2
	if ft3<=0 then return end
	if ft3>4 then ft3=4 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1015.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,ft3,nil,e,tp)
	local tc=g:GetFirst()
	local cg=0
	while tc do
	    local ct1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	    local ct2=Duel.GetLocationCount(tp,LOCATION_SZONE)
	    if ct1>0 and ct2>0 then 
		    if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(1003,0)) then
		        Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
				cg=cg+1
            else 
		        Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		        local e1=Effect.CreateEffect(c)
				e1:SetCode(EFFECT_CHANGE_TYPE)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetReset(RESET_EVENT+0x1fc0000)
				e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
				tc:RegisterEffect(e1)
				cg=cg+1
			end	
        elseif ct1>0 and ct2<=0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
	        Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(c)
	        e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
	        e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
            e1:SetRange(LOCATION_MZONE)
		    e1:SetReset(RESET_EVENT+0x1fe0000)
	        tc:RegisterEffect(e1)
			cg=cg+1
	    else
	        Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		    local e1=Effect.CreateEffect(c)
		    e1:SetCode(EFFECT_CHANGE_TYPE)
		    e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    	e1:SetReset(RESET_EVENT+0x1fc0000)
	    	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	    	tc:RegisterEffect(e1)
			cg=cg+1
		end
		tc=g:GetNext()
		Duel.SpecialSummonComplete()
	end
	Duel.Damage(tp,cg*500,REASON_EFFECT)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(c1015.val)
	e2:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e2,tp)
end	
function c1015.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then
		return dam/2
	else return dam end
end