--深海栖姬-孤岛栖鬼
function c233623.initial_effect(c)
    --synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,0x2),1)
	c:EnableReviveLimit()
	--spsummon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233623,4))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c233623.condition)
	e1:SetTarget(c233623.target)
	e1:SetOperation(c233623.operation)
	c:RegisterEffect(e1)
end	
function c233623.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==0x46000000 
end
function c233623.filter(c)
	return c:IsFaceup() and c:IsType(0x2000) and c:GetAttack()>0
end
function c233623.rfilter(c)
	return c:IsType(0xc0) and c:IsAbleToRemove()
end
function c233623.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local sel=0
		if Duel.GetOverlayCount(tp,0,1)>0 then sel=sel+1 end
		if Duel.IsExistingMatchingCard(c233623.filter,tp,0,0x4,1,nil) then sel=sel+2 end
		if Duel.IsExistingMatchingCard(c233623.rfilter,tp,0,0xc,1,nil) then sel=sel+3 end
		e:SetLabel(sel)
		return sel~=0
	end
	local sel=e:GetLabel()
	if sel==3 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(233623,0))
		sel=Duel.SelectOption(tp,aux.Stringid(233623,1),aux.Stringid(233623,2))+1
	elseif sel>3 then
	    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(233623,0))
     	sel=Duel.SelectOption(tp,aux.Stringid(233623,1),aux.Stringid(233623,2),aux.Stringid(233623,3))+1
	end
	e:SetLabel(sel)
	if sel==3 then
	local g=Duel.GetMatchingGroup(c233623.rfilter,tp,0,0xc,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0) end
end
function c233623.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sel=e:GetLabel()
	if sel==1 then
	local g=Duel.GetOverlayGroup(tp,0,1)
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(g:GetCount()*1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
	elseif sel==2 then 
	    local g=Duel.GetMatchingGroup(c233623.filter,tp,0,0x4,nil)
		if g:GetCount()==0 then return end
		local atk=0
		local tc=g:GetFirst()
		while tc do
		atk=atk+tc:GetAttack()/2
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	if atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end	
	else
	   local g=Duel.GetMatchingGroup(c233623.rfilter,tp,0,0xc,nil)
	   if g:GetCount()==0 then return end
	   Duel.Remove(g,0x5,0x40) 
	end 
end   