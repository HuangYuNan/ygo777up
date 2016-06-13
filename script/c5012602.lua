--御坂美琴
function c5012602.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c5012602.spcon)
	e1:SetOperation(c5012602.spop)
	c:RegisterEffect(e1)
	 --add setcode
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_ADD_SETCODE)
	e3:SetValue(0x350)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetValue(0x23c)
	c:RegisterEffect(e4)
	--buff
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCountLimit(1,5012602)
	e5:SetCost(c5012602.cost)
	e5:SetTarget(c5012602.tg)
	e5:SetOperation(c5012602.op)
	c:RegisterEffect(e5)
end
function c5012602.spcon(e,c)
	if c==nil then return true end
	return  Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c5012602.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-500)
	e1:SetReset(RESET_EVENT+0xff0000)
	e:GetHandler():RegisterEffect(e1)
end
function c5012602.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c5012602.refilter(c)
	return c:IsFaceup() and  (c:IsSetCard(0x350) or c:IsSetCard(0x23c) ) 
end
function c5012602.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5012602.refilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c5012602.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5012602.refilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tg=g:GetFirst()
	while tg do
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tg:RegisterEffect(e1)
	tg=g:GetNext()
	end
end