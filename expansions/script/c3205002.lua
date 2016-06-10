--驱魔师 神田
function c3205002.initial_effect(c)
    --indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c3205002.indes)
	c:RegisterEffect(e1)
    --atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c3205002.atkcon)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3205002,2))
	e3:SetCountLimit(1,3205002)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c3205002.atcon)
	e3:SetOperation(c3205002.atop)
	c:RegisterEffect(e3)
end
function c3205002.indes(e,c)
	return c:GetAttack()==e:GetHandler():GetAttack()
end
function c3205002.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x340)
end
function c3205002.atkcon(e)
	local c=e:GetHandler()
	return not Duel.IsExistingMatchingCard(c3205002.filter,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c3205002.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:GetFlagEffect(3205002)==0
		and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE) 
end
function c3205002.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end