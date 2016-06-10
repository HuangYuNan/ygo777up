--仙境国与魔术乡
function c66612323.initial_effect(c)
	c:SetUniqueOnField(1,0,66612323)
	---
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-----
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c66612323.cpcost)
	e2:SetTarget(c66612323.cptg)
	e2:SetOperation(c66612323.cpop)
	c:RegisterEffect(e2)
	---
end
function c66612323.cpfilter(c)
	return c:IsSetCard(0x660) and c:IsAbleToDeckAsCost() and c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,true)~=nil 
end
function c66612323.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66612323.cpfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c66612323.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local rtc=g:GetFirst()
	Duel.SendtoDeck(rtc,nil,2,REASON_COST)
	e:SetLabelObject(rtc)
end
function c66612323.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e:SetCategory(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local rtc=e:GetLabelObject()
	local te=rtc:CheckActivateEffect(true,true,false)
	Duel.ClearTargetCard()
	rtc:CreateEffectRelation(e)
	e:SetLabelObject(te)
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	local cg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not cg then return end
	local tc=cg:GetFirst()
	while tc do
		tc:CreateEffectRelation(te)
		tc=cg:GetNext()
	end
end
function c66612323.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if te:GetHandler():IsRelateToEffect(e) then
		local op=te:GetOperation()
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		local cg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if not cg then return end
		local tc=cg:GetFirst()
		while tc do
			tc:ReleaseEffectRelation(te)
			tc=cg:GetNext()
		end
	end
end