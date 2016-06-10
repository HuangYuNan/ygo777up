--学园媒体 学徒型索尔
function c60150714.initial_effect(c)
	c:SetUniqueOnField(1,0,60150714)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60150706,60150708,false,false)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	e11:SetValue(c60150714.splimit)
	c:RegisterEffect(e11)
	--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60150714,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c60150714.hdcon)
	e3:SetTarget(c60150714.hdtg)
	e3:SetOperation(c60150714.hdop)
	c:RegisterEffect(e3)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c60150714.spcon)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	local e4=e5:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(aux.tgval)
	c:RegisterEffect(e4)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c60150714.thtg2)
	e1:SetOperation(c60150714.thop2)
	c:RegisterEffect(e1)
end
function c60150714.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c60150714.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c60150714.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c60150714.cfilter,1,nil,1-tp)
end
function c60150714.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function c60150714.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0,nil)
	local rs=g:RandomSelect(1-tp,1)
	local card=rs:GetFirst()
	if card==nil then return end
	if Duel.Remove(card,POS_FACEDOWN,REASON_EFFECT)>0 then
		local ph=Duel.GetCurrentPhase()
		local cp=Duel.GetTurnPlayer()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,3)
		e1:SetCondition(c60150714.thcon)
		e1:SetOperation(c60150714.thop)
		e1:SetLabel(1)
		card:RegisterEffect(e1)
		e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
		c60150714[e:GetHandler()]=e1
	end
end
function c60150714.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c60150714.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	e:GetOwner():SetTurnCounter(ct)
	if ct==3 then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		e:GetOwner():ResetFlagEffect(1082946)
	else
		e:SetLabel(ct+1)
	end
end
function c60150714.cfilter2(c)
	return c:IsFacedown()
end
function c60150714.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsPosition,e:GetHandlerPlayer(),0,LOCATION_REMOVED,1,nil,POS_FACEDOWN)
end
function c60150714.thfilter(c)
	return c:IsFacedown() and c:IsAbleToHand()
end
function c60150714.thtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(1-tp) and c60150714.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150714.thfilter,tp,0,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c60150714.thfilter,tp,0,LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c60150714.thop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_SKIP_DP)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_END,3)
		Duel.RegisterEffect(e1,tp)
	end
end
function c60150714.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel()
end
function c60150714.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetHandler())
	e:Reset()
end