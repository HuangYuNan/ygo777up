--4
function c20150303.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150303,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_REPEAT)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c20150303.condition1)
	e1:SetTarget(c20150303.target)
	e1:SetOperation(c20150303.operation)
	c:RegisterEffect(e1)
	--damege
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20150303,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e2:SetOperation(c20150303.activate)
	c:RegisterEffect(e2)
		--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20150303,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,20150303)
	e3:SetTarget(c20150303.rmtg)
	e3:SetOperation(c20150303.rmop)
	c:RegisterEffect(e3)
end
function c20150303.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c20150303.val)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c20150303.val(e,re,dam,r,rp,rc)
	if c20150303[e:GetOwnerPlayer()]==1 or bit.band(r,REASON_BATTLE)~=0 then
		return dam/2
	else return dam end
end
function c20150303.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()
end
function c20150303.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c20150303.operation(e,tp,eg,ep,ev,re,r,rp)
	local rt=Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)*100
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rt,REASON_EFFECT)
end
function c20150303.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,20150303)==0 and e:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
	Duel.RegisterFlagEffect(tp,20150303,RESET_PHASE+PHASE_END,0,1)
end
function c20150303.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(c)
		e1:SetCountLimit(1)
		e1:SetOperation(c20150303.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c20150303.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
