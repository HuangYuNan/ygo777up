--超！学生会长 学徒型橄榄石
function c60150709.initial_effect(c)
	c:SetUniqueOnField(1,0,60150709)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60150701,60150708,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c60150709.splimit)
	c:RegisterEffect(e1)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60150709,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c60150709.cacon)
	e3:SetTarget(c60150709.catg)
	e3:SetOperation(c60150709.caop)
	c:RegisterEffect(e3)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c60150709.damcon)
	e4:SetOperation(c60150709.damop)
	c:RegisterEffect(e4)
end
function c60150709.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c60150709.cacon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsChainAttackable()
end
function c60150709.filter(c)
	return c:IsFaceup() and c:IsAttackPos() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c60150709.catg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c60150709.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150709.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c60150709.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c60150709.caop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		--Duel.ChainAttack(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetLabelObject(tc)
		e3:SetValue(c60150709.exttg)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e3)
		e2:SetLabelObject(e3)
		e1:SetLabelObject(e2)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_ATTACK_ANNOUNCE)
		e4:SetLabelObject(e1)
		e4:SetOperation(c60150709.atrst)
		e4:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		Duel.RegisterEffect(e4,tp)
	end
end
function c60150709.exttg(e,c)
	local tc=e:GetLabelObject()
	return c~=tc
end
function c60150709.atrst(e,tp,eg,ep,ev,re,r,rp)
	local e1=e:GetLabelObject()
	local e2=e1:GetLabelObject()
	local e3=e2:GetLabelObject()
	if eg:GetFirst()~=e1:GetHandler() then
		e1:Reset()
		e2:Reset()
		e3:Reset()
	end
end
function c60150708.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c60150709.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetBattleTarget()~=nil and e:GetHandler():GetBattleTarget():IsAttribute(ATTRIBUTE_LIGHT) 
end
function c60150709.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end