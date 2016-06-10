--神之曲 继承之章
function c75000061.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c75000061.cost)
	e1:SetTarget(c75000061.target)
	e1:SetOperation(c75000061.activate)
	c:RegisterEffect(e1)
end
function c75000061.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000061.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75000061.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_SYNCHRO) or tc:IsType(TYPE_XYZ) then
		e:GetHandler():RegisterFlagEffect(75000061,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c75000061.filter1(c)
	return c:IsSetCard(0x52f) and c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function c75000061.filter2(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsType(TYPE_PENDULUM) and c:IsFaceup()
end
function c75000061.filter3(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM)
end
function c75000061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c75000061.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c75000061.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c75000061.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local c=e:GetHandler()
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local tc=sg:GetFirst()
	if g:GetCount()>0 then 
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		if Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local tn=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
			local mn=tn:GetFirst()
			Duel.Destroy(mn,REASON_EFFECT)
			if c:GetFlagEffect(75000061)>0  and Duel.IsExistingMatchingCard(c75000061.filter3,tp,LOCATION_DECK,0,1,nil,e,tp) and (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil or Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) then
				if Duel.SelectYesNo(tp,aux.Stringid(75000061,0)) then
					Duel.BreakEffect()
					local tg=Duel.SelectMatchingCard(tp,c75000061.filter3,tp,LOCATION_DECK,0,1,1,nil,tp)
					local tc=tg:GetFirst()
					Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				end
			end
		end 
	end
end