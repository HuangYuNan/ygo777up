--神之曲 交锋之章
function c75000019.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75000019)
	e1:SetTarget(c75000019.target)
	e1:SetOperation(c75000019.activate)
	c:RegisterEffect(e1)
end
function c75000019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil,e,tp) and Duel.IsExistingTarget(c75000019.filter,tp,LOCATION_ONFIELD,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g1=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local g2=Duel.SelectTarget(tp,c75000019.filter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),e,tp)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY+CATEGORY_REMOVE,g1,g1:GetCount(),0,0)
end
function c75000019.filter(c)
	return c:IsSetCard(0x52f) and c:IsAbleToRemove() and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_PENDULUM))
end
function c75000019.filter2(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and c:IsFaceup()
end
function c75000019.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local off=1
	local ops={}
	local opval={}
	tg=g:Filter(Card.IsDestructable,nil)
	if tg:GetCount()==2 then
		ops[off]=aux.Stringid(75000019,0)
		opval[off-1]=1
		off=off+1
	end
	tg2=g:Filter(Card.IsAbleToRemove,nil)
	if tg2:GetCount()==2 then
		ops[off]=aux.Stringid(75000019,1)
		opval[off-1]=2
		off=off+1
	end
	if off==1 then return end
	local op=Duel.SelectOption(tp,table.unpack(ops))
	if opval[op]==1 then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		if sg:GetCount()>0 then
			Duel.Destroy(tg,REASON_EFFECT)
			Duel.BreakEffect()
			if Duel.IsExistingMatchingCard(c75000019.filter2,tp,LOCATION_EXTRA,0,1,nil) and (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil or Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) then
				if Duel.SelectYesNo(tp,aux.Stringid(75000019,2)) then
				local g=Duel.SelectMatchingCard(tp,c75000019.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tp)
				local tc=g:GetFirst()
				if tc then
					Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				end
			end
		end
	end
	elseif opval[op]==2 then
		local sg1=g:Filter(Card.IsRelateToEffect,nil,e)
		if sg1:GetCount()>0 then
			Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
		end
	end
end