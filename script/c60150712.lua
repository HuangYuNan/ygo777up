--学舍的大轮华 学徒型罗艾娜
function c60150712.initial_effect(c)
	c:SetUniqueOnField(1,0,60150712)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60150704,60150708,false,false)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	e11:SetValue(c60150712.splimit)
	c:RegisterEffect(e11)
	--atk/def down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetCondition(c60150712.adcon)
	e2:SetOperation(c60150712.addown)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c60150712.efilter)
	c:RegisterEffect(e3)
end
function c60150712.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c60150712.adcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c60150712.addown(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc==nil then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
	e1:SetValue(tc:GetAttack()/2)
	tc:RegisterEffect(e1)
end
function c60150712.efilter(e,te)
	if te:IsActiveType(TYPE_MONSTER) then
		local ec=te:GetOwner()
		return ec:GetAttack()~=ec:GetTextAttack() and te:GetOwner()~=e:GetOwner()
	end
end