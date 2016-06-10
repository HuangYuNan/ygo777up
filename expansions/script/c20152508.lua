--『 』
function c20152508.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsCode,20152501),aux.FilterBoolFunction(Card.IsCode,20152502),true)
		--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c20152508.sprcon)
	e2:SetOperation(c20152508.sprop)
	c:RegisterEffect(e2)
		--immune spell
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c20152508.efilter)
	c:RegisterEffect(e3)
	--atk
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetRange(LOCATION_MZONE)
	--e4:SetValue(c20152508.adval)
	--c:RegisterEffect(e4)
	--local e5=e4:Clone()
	--e5:SetCode(EFFECT_SET_DEFENSE_FINAL)
	--c:RegisterEffect(e5)
	--tohand
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(20152508,2))
	e6:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c20152508.target2)
	e6:SetOperation(c20152508.operation2)
	c:RegisterEffect(e6)
	--battle indestructable
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	--atk & def
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c20152508.atkcon)
	e8:SetTarget(c20152508.atktg)
	e8:SetOperation(c20152508.atkop)
	c:RegisterEffect(e8)
end
function c20152508.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
	function c20152508.spfilter1(c,tp)
	return c:IsCode(20152501) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
		and Duel.IsExistingMatchingCard(c20152508.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c20152508.spfilter2(c)
	return c:IsCode(20152502) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
end
function c20152508.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c20152508.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c20152508.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c20152508.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c20152508.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c20152508.filter(c)
	return c:IsFaceup() and c:GetCode()~=20152508
end
--function c20152508.adval(e,c)
	--local g=Duel.GetMatchingGroup(c20152508.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	--if g:GetCount()==0 then 
		--return 100
	--else
		--local tg,val=g:GetMaxGroup(Card.GetAttack)
		--return val+100
	--end
--end
function c20152508.filter2(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c20152508.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152508.filter2,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c20152508.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20152508.filter2,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20152508.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end
function c20152508.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c)
		if g:GetCount()==0 then return false end
		local g1,atk=g:GetMaxGroup(Card.GetAttack)
		return c:GetAttack()~=atk and c:GetFlagEffect(58421231)==0
	end
	c:RegisterFlagEffect(58421231,RESET_CHAIN,0,1)
end
function c20152508.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	if g:GetCount()==0 then return end
	local g1,atk=g:GetMaxGroup(Card.GetAttack)
	if c:IsRelateToEffect(e) and c:IsFaceup() and atk>=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk+100)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		c:RegisterEffect(e2)
	end
end