--口袋妖怪 飞天螳螂
function c80000166.initial_effect(c)
--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x2d0),4,2)
	c:EnableReviveLimit() 
--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80000166,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c80000166.descost)
	e1:SetTarget(c80000166.target)
	e1:SetProperty(0)
	e1:SetOperation(c80000166.operation)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c80000166.atkcon)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetCondition(c80000166.atkcon)
	e3:SetValue(c80000166.tgvalue)
	c:RegisterEffect(e3)
end
function c80000166.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c80000166.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c80000166.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,80000169)
end
function c80000166.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and c80000166.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,80000169,0x2d0,0x4011,c:GetBaseAttack(),c:GetBaseDEFENSE(),c:GetOriginalLevel(),c:GetOriginalRace(),c:GetOriginalAttribute()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(80000166,0))
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
end
function c80000166.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		local atk=c:GetAttack()
		local def=c:GetDEFENSE()
		local lv=c:GetLevel()
		local race=c:GetRace()
		local att=c:GetAttribute()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not c:IsRelateToEffect(e) or c:IsFacedown()
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,80000169,0x2d0,0x4011,atk,def,lv,race,att) then return end
		local token1=Duel.CreateToken(tp,80000169)
		c:CreateRelation(token1,RESET_EVENT+0x1fe0000)
		Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c80000166.tokenatk)
		e1:SetReset(RESET_EVENT+0xfe0000)
		token1:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(c80000166.tokendef)
		token1:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(4)
		e3:SetReset(RESET_EVENT+0xfe0000)
		token1:RegisterEffect(e3,true)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(c80000166.tokenrace)
		e4:SetReset(RESET_EVENT+0xfe0000)
		token1:RegisterEffect(e4,true)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(c80000166.tokenatt)
		e5:SetReset(RESET_EVENT+0xfe0000)
		token1:RegisterEffect(e5,true)
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_SELF_DESTROY)
		e6:SetCondition(c80000166.tokendes)
		e6:SetReset(RESET_EVENT+0xfe0000)
		token1:RegisterEffect(e6,true)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e7:SetValue(1)
		e7:SetReset(RESET_EVENT+0x1fe0000)
		token1:RegisterEffect(e7,true)
		local e8=e7:Clone()
		e8:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		token1:RegisterEffect(e8,true)
		local e9=Effect.CreateEffect(c)
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e9:SetValue(1)
		e9:SetReset(RESET_EVENT+0x1fe0000)
		token1:RegisterEffect(e9,true)
		local e10=Effect.CreateEffect(c)
		e10:SetType(EFFECT_TYPE_SINGLE)
		e10:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e10:SetValue(1)
		e10:SetReset(RESET_EVENT+0x1fe0000)
		token1:RegisterEffect(e10,true)
		Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
		local token2=Duel.CreateToken(tp,80000169)
		c:CreateRelation(token2,RESET_EVENT+0x1fe0000)
		Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c80000166.tokenatk)
		e1:SetReset(RESET_EVENT+0xfe0000)
		token2:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(c80000166.tokendef)
		token2:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(4)
		e3:SetReset(RESET_EVENT+0xfe0000)
		token2:RegisterEffect(e3,true)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(c80000166.tokenrace)
		e4:SetReset(RESET_EVENT+0xfe0000)
		token2:RegisterEffect(e4,true)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(c80000166.token2att)
		e5:SetReset(RESET_EVENT+0xfe0000)
		token2:RegisterEffect(e5,true)
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_SELF_DESTROY)
		e6:SetCondition(c80000166.tokendes)
		e6:SetReset(RESET_EVENT+0xfe0000)
		token2:RegisterEffect(e6,true)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e7:SetValue(1)
		e7:SetReset(RESET_EVENT+0x1fe0000)
		token2:RegisterEffect(e7,true)
		local e8=e7:Clone()
		e8:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		token2:RegisterEffect(e8,true)
		local e9=Effect.CreateEffect(c)
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e9:SetValue(1)
		e9:SetReset(RESET_EVENT+0x1fe0000)
		token2:RegisterEffect(e9,true)
		local e10=Effect.CreateEffect(c)
		e10:SetType(EFFECT_TYPE_SINGLE)
		e10:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e10:SetValue(1)
		e10:SetReset(RESET_EVENT+0x1fe0000)
		token2:RegisterEffect(e10,true)
		Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummonComplete()
	end
function c80000166.tokenatk(e,c)
	return e:GetOwner():GetAttack()
end
function c80000166.tokendef(e,c)
	return e:GetOwner():GetDEFENSE()
end
function c80000166.tokenlv(e,c)
	return e:GetOwner():GetLevel()
end
function c80000166.tokenrace(e,c)
	return e:GetOwner():GetRace()
end
function c80000166.tokenatt(e,c)
	return e:GetOwner():GetAttribute()
end
function c80000166.tokendes(e)
	return not e:GetOwner():IsRelateToCard(e:GetHandler())
end