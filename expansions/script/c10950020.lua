--GhostChild
function c10950020.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10950020.spcon)
	e0:SetOperation(c10950020.spop)
	c:RegisterEffect(e0)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c10950020.damcon)
	e4:SetOperation(c10950020.damop)
	c:RegisterEffect(e4)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10950020,0))
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c10950020.discon)
	e5:SetTarget(c10950020.distg)
	e5:SetOperation(c10950020.disop)
	c:RegisterEffect(e5)
	--replace
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10950020,1))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_CHAINING)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c10950020.condition)
	e6:SetCost(c10950020.cost)
	e6:SetTarget(c10950020.target)
	e6:SetOperation(c10950020.operation)
	c:RegisterEffect(e6)
	--destroy
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(10950020,2))
	e9:SetCategory(CATEGORY_DESTROY)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetTarget(c10950020.target2)
	e9:SetOperation(c10950020.operation2)
	c:RegisterEffect(e9)
end
function c10950020.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetBattleTarget()~=nil
end
function c10950020.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
function c10950020.spfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsType(TYPE_TUNER) and c:IsAbleToGraveAsCost()
end
function c10950020.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x231)
end
function c10950020.syc(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,5,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x13ac,5,REASON_COST)
end
function c10950020.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 
	and Duel.IsExistingMatchingCard(c10950020.spfilter2,tp,LOCATION_MZONE,0,3,nil) then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,5,REASON_COST) and Duel.IsExistingMatchingCard(c10950020.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) 
end
end
function c10950020.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10950020.spfilter,c:GetControler(),LOCATION_MZONE,0,1,1,nil)
	Duel.RemoveCounter(tp,1,0,0x13ac,5,REASON_COST)
	Duel.SendtoGrave(g,REASON_COST) 
end
function c10950020.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c10950020.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10950020.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c10950020.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c10950020.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
function c10950020.condition(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField()
end
function c10950020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x13ac,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x13ac,2,REASON_COST)
end
function c10950020.filter(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c)
end
function c10950020.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc:IsOnField() and c10950020.filter(chkc,re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	if chk==0 then return Duel.IsExistingTarget(c10950020.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c10950020.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp)
end
function c10950020.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end