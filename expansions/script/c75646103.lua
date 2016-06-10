--七子
function c75646103.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c75646103.spcon)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--damage reduce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetCondition(c75646103.rdcon)
	e3:SetOperation(c75646103.rdop)
	c:RegisterEffect(e3)
	--tohandes
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(75646103,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCountLimit(1,75646103)
	e4:SetCondition(c75646103.condition)
	e4:SetTarget(c75646103.target)
	e4:SetOperation(c75646103.activate)
	c:RegisterEffect(e4)
end
function c75646103.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2c0) and not c:IsCode(75646103) and c:IsType(TYPE_MONSTER)
end
function c75646103.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75646103.filter1,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c75646103.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c==Duel.GetAttacker() and Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c75646103.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
function c75646103.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c75646103.filter(c)
	return c:IsSetCard(0x2c0) and c:IsAbleToHand() and not c:IsCode(75646103)
end
function c75646103.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646103.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75646103.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75646103.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end