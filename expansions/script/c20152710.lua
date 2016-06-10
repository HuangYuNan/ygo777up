--川崎沙希
function c20152710.initial_effect(c)
c:SetUniqueOnField(1,0,20152710) 
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152710,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c20152710.descon)
	e2:SetTarget(c20152710.destg)
	e2:SetOperation(c20152710.desop)
	c:RegisterEffect(e2)
		--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152710,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c20152710.thtg)
	e3:SetOperation(c20152710.thop2)
	c:RegisterEffect(e3)
		--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c20152710.indtg)
	e4:SetValue(c20152710.indval)
	c:RegisterEffect(e4)
end
function c20152710.cxfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0xc290) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c20152710.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20152710.cxfilter,1,nil,tp)
end
function c20152710.desxfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup() and c:IsDestructable()
end
function c20152710.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152710.desxfilter,tp,LOCATION_SZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c20152710.desxfilter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c20152710.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c20152710.desxfilter,tp,LOCATION_SZONE,0,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 and Duel.IsPlayerCanDraw(tp,ct) and Duel.SelectYesNo(tp,aux.Stringid(74700120,1)) then
		Duel.BreakEffect()
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
function c20152710.xfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsAbleToHand()
end
function c20152710.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c20152710.xfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152710.xfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c20152710.xfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c20152710.thop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c20152710.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_SZONE) and (c:GetSequence()==6 or c:GetSequence()==7)
		and c:IsReason(REASON_EFFECT)
end
function c20152710.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20152710.filter,1,nil,tp) end
	return true
end
function c20152710.indval(e,c)
	return c20152710.filter(c,e:GetHandlerPlayer())
end
