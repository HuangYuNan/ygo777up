--鸣护艾丽纱
function c10953636.initial_effect(c)
	c:SetUniqueOnField(1,0,10953636)
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c10953636.splimit)
	c:RegisterEffect(e0)
	--cannot release
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetCondition(c10953636.desrepcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	--cannot target
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e6:SetCondition(c10953636.desrepcon)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	--equip
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(10953636,0))
	e7:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetTarget(c10953636.eqtg)
	e7:SetOperation(c10953636.eqop)
	c:RegisterEffect(e7)
	--change effect
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(10953636,1))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_CHAINING)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCountLimit(1)
	e8:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e8:SetCondition(c10953636.chcon)
	e8:SetTarget(c10953636.chtg)
	e8:SetOperation(c10953636.chop)
	c:RegisterEffect(e8)
	--Destroy replace
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCondition(c10953636.desrepcon2)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_IMMUNE_EFFECT)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(LOCATION_SZONE,0)
	e10:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x350))
	e10:SetCondition(c10953636.desrepcon3)
	e10:SetValue(c10953636.efilter)
	c:RegisterEffect(e10)
	--pos
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(10953636,2))
	e11:SetCategory(CATEGORY_POSITION)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetHintTiming(0,0x1e0)
	e11:SetCountLimit(1)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c10953636.desrepcon4)
	e11:SetTarget(c10953636.target2)
	e11:SetOperation(c10953636.operation2)
	c:RegisterEffect(e11)
	--attack up
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(10953636,3))
	e12:SetCategory(CATEGORY_ATKCHANGE)
	e12:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e12:SetCondition(c10953636.con)
	e12:SetOperation(c10953636.op)
	c:RegisterEffect(e12)
end
function c10953636.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(10953635)
end
function c10953636.filter(c)
	return c:IsSetCard(0x350) 
end
function c10953636.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10953636.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c10953636.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c10953636.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c10953636.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c10953636.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c10953636.eqlimit(e,c)
	return e:GetOwner()==c and not c:IsDisabled()
end
function c10953636.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x350)
end
function c10953636.desrepcon(e)
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,1,nil)
end
function c10953636.desrepcon2(e)
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,3,nil)
end
function c10953636.desrepcon3(e)
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,4,nil)
end
function c10953636.desrepcon4(e)
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,5,nil)
end
function c10953636.chcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,2,nil) and re:IsActiveType(TYPE_MONSTER)
		or (rc:GetType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c10953636.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10953636.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c10953636.repop)
end
function c10953636.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetType()==TYPE_SPELL then
		c:CancelToGrave(false)
	end
	Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c10953636.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c10953636.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c10953636.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE,POS_FACEDOWN_DEFENCE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
function c10953636.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c10953636.filter1,e:GetHandler():GetControler(),LOCATION_SZONE,0,6,nil) and c:GetFlagEffect(10953636)==0 and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
end
function c10953636.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(3400)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e2:SetValue(3400)
	c:RegisterEffect(e2)
end