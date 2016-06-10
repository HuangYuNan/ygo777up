--藏书屋·芙兰朵露
function c6000029.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x300),2,true)
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c6000029.condition)
	e1:SetOperation(c6000029.operation)
	c:RegisterEffect(e1)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c6000029.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c6000029.limit)
	c:RegisterEffect(e7)
end
function c6000029.filter(c)
	return c:GetAttack()==0 and c:IsDestructable()
end
function c6000029.condition(e,tp,eg,ep,ev,re,r,rp) 
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION 
end
function c6000029.operation(e,tp,eg,ep,ev,re,r,rp)
	   local c=e:GetHandler()
	   local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	   local tc=tg:GetFirst()
	   while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=tg:GetNext()
	   end
		local dg=Duel.GetMatchingGroup(c6000029.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	   if dg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Destroy(dg,REASON_EFFECT)
	   end
end
function c6000029.limit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x300)
end