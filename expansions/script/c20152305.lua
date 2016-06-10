--赤城濑菜
function c20152305.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(2,20152305)
	e2:SetTarget(c20152305.destg)
	e2:SetOperation(c20152305.desop)
	c:RegisterEffect(e2)
	--to hand, atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152305,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c20152305.target3)
	e3:SetOperation(c20152305.operation3)
	c:RegisterEffect(e3)
	--splimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(1,0)
	e4:SetCondition(function(e) return not e:GetHandler():IsHasEffect(EFFECT_FORBIDDEN) end)
	e4:SetTarget(c20152305.splimit)
	c:RegisterEffect(e4)
	--scale
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetCode(EFFECT_CHANGE_LSCALE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetRange(LOCATION_PZONE)
	--e4:SetCondition(c20152305.sccon)
	--e4:SetValue(4)
	--c:RegisterEffect(e4)
	--local e5=e4:Clone()
	--e5:SetCode(EFFECT_CHANGE_RSCALE)
	--c:RegisterEffect(e5)
end
function c20152305.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x5290)
end
function c20152305.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and tc and tc:IsSetCard(0x5290) and not tc:IsCode(20152305) and e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c20152305.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c20152305.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
		and (c:IsReason(REASON_EFFECT) or (c:IsReason(REASON_BATTLE) and Duel.GetAttacker():IsControler(1-tp)))
end
function c20152305.sccon(e)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	return not tc or not tc:IsSetCard(0x5290)
end
function c20152305.filter3(c)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsSetCard(0x5290)
end
function c20152305.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c20152305.filter3(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152305.filter3,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c20152305.filter3,tp,LOCATION_ONFIELD,0,1,99,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c20152305.operation3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local rg=tg:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoHand(rg,nil,REASON_EFFECT)
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.BreakEffect()
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_HAND)
		if ct>0 then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_UPDATE_ATTACK)
			e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			e3:SetValue(ct*300)
			c:RegisterEffect(e3)
		end
	end
end