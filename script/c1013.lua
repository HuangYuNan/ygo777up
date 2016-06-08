--人形「未来文乐」
function c1013.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1013+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c1013.target)
	e1:SetOperation(c1013.operation)
	c:RegisterEffect(e1)
end
function c1013.filter(c)
	return c:IsLevelAbove(1) and  c:IsSetCard(0x989) 
end
function c1013.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	 if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c1013.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1013.filter,tp,LOCATION_MZONE,0,1,nil) and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)	end
	local g=Duel.SelectTarget(tp,c1013.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c1013.operation(e,tp,eg,ep,ev,re,r,rp)
   	local tc=Duel.GetFirstTarget()
   if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then 
	if Duel.SelectYesNo(tp,aux.Stringid(1012,3)) then 
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if  tc:IsRelateToEffect(e)   then
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
	Duel.MoveSequence(tc,nseq)
	end
	else 
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if  tc:IsFaceup(e) then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		end
end
    elseif  Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if  tc:IsRelateToEffect(e)   then
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
	Duel.MoveSequence(tc,nseq)
	end
	elseif  Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if  tc:IsFaceup(e) then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		end
	end
	 Duel.RaiseEvent(e:GetHandler(),1003,e,0,tp,0,0)
       Duel.RaiseSingleEvent(tc,1001,e,0,0,0,0)
		if e:GetHandler():IsRelateToEffect(e) then
		Duel.Draw(tp,1,REASON_EFFECT)
		end
end
   