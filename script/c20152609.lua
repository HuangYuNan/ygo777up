--毕娜
function c20152609.initial_effect(c)
	c:SetUniqueOnField(1,0,20152609)
	--Cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)  
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetCondition(c20152609.splimcon)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
			--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetTarget(c20152609.tg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
			--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetTarget(c20152609.tg)
e3:SetValue(c20152609.efr)
	c:RegisterEffect(e3)
		--replace
	local e4=Effect.CreateEffect(c) e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c20152609.indtg)
	e4:SetValue(c20152609.indval)
	c:RegisterEffect(e4)
		--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20152609,0))
	e5:SetCategory(CATEGORY_RECOVER)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLE_DAMAGE)
	e5:SetCondition(c20152609.condition)
	e5:SetTarget(c20152609.rectg)
	e5:SetOperation(c20152609.recop)
	c:RegisterEffect(e5)
			--destroy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_RECOVER)
	e6:SetDescription(aux.Stringid(20152609,1))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_REMOVE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetTarget(c20152609.rectg2)
	e6:SetOperation(c20152609.recop2)
	c:RegisterEffect(e6)
end
function c20152609.tg(e,c)
	return c:IsFaceup() and (c:IsCode(20152614) or c:IsCode(20152636))
end
function c20152609.efr(e,re)
	return re:GetHandler():GetControler()~=e:GetHandler():GetControler()
end
function c20152609.indfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsReason(REASON_EFFECT)
		and (c:IsCode(20152614) or c:IsCode(20152636)) and c:IsLocation(LOCATION_MZONE)
end
function c20152609.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20152609.indfilter,1,nil,tp) end
	return true
end
function c20152609.indval(e,c)
	return c20152609.indfilter(c,e:GetHandlerPlayer())
end
function c20152609.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c20152609.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,2000)
end
function c20152609.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c20152609.rectg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c20152609.recop2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c20152609.cfilter(c)
	return c:IsFaceup() and (c:IsCode(20152614) or c:IsCode(20152636))
end
function c20152609.splimcon(e)
	return not Duel.IsExistingMatchingCard(c20152609.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
