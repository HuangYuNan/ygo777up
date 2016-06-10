--奇迹元素·阿特摩斯
function c37564001.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3,nil,nil,5)
	c:EnableReviveLimit()   
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c37564001.con)
	e2:SetOperation(c37564001.op)
	c:RegisterEffect(e2)
	--攻击
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(37564001,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c37564001.cost)
	e1:SetOperation(c37564001.operation)
	c:RegisterEffect(e1)
   --half damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD+EFFECT_CANNOT_DISABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c37564001.dcon)
	e4:SetOperation(c37564001.dop)
	c:RegisterEffect(e4)
end
function c37564001.con(e)
	return e:GetHandler():GetOverlayCount()>0 and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
	and e:GetHandler():GetBattleTarget()
end
function c37564001.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e2)
end
function c37564001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37564001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c37564001.dcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget()) and e:GetHandler():GetOverlayCount()==0
end
function c37564001.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end