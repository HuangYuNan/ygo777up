--歌莉亚人形
function c1009.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c1009.ffilter,2,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c1009.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c1009.sprcon)
	e2:SetOperation(c1009.sprop)
	c:RegisterEffect(e2)
	--[[--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c1009.atkval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)--]]
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(1009,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetCondition(c1009.descon)
	e5:SetTarget(c1009.destg)
	e5:SetOperation(c1009.desop)
	c:RegisterEffect(e5)
	--no battle
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(1009,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_BATTLE_START)
	e6:SetCondition(c1009.dmcon)
	e6:SetTarget(c1009.dmtg)
	e6:SetOperation(c1009.dmop)
	c:RegisterEffect(e6)
	--index
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e7:SetRange(LOCATION_ONFIELD)
	e7:SetTargetRange(LOCATION_ONFIELD,0)
	e7:SetCondition(c1009.incon)
	e7:SetTarget(c1009.intg)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e8:SetValue(c1009.invalue)
	c:RegisterEffect(e8)
end
function c1009.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c1009.ffilter(c)
	return c:IsSetCard(0x989) and c:GetLevel()==1
end
function c1009.spfilter(c)
	return c:IsSetCard(0x989) and c:GetLevel()==1 and c:IsCanBeFusionMaterial() and c:IsAbleToGraveAsCost()
end
function c1009.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-5
		and Duel.IsExistingMatchingCard(c1009.spfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c1009.sprop(e,tp,eg,ep,ev,re,r,rp,c)
    local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1009.spfilter,tp,LOCATION_MZONE,0,2,5,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g:GetNext()
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_COST)
end
function c1009.atkval(e,c)
    local ct=e:GetHandler():GetMaterialCount()
	return ct*200
end
function c1009.descon(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetMaterialCount()
	return ct>=2 and e:GetHandler():GetPreviousLocation()==LOCATION_EXTRA
end
function c1009.desfilter(c,seq)
	return c:GetSequence()==seq and c:IsDestructable()
end
function c1009.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1009.desfilter,tp,0,LOCATION_ONFIELD,1,nil,4-e:GetHandler():GetSequence()) end
	local g=Duel.GetMatchingGroup(c1009.desfilter,tp,0,LOCATION_ONFIELD,nil,4-e:GetHandler():GetSequence())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	local tc=g:GetFirst()
	while tc do
	Duel.SetChainLimit(c1009.limit(tc))
	tc=g:GetNext()
	end
end
function c1009.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end 
	local g=Duel.GetMatchingGroup(c1009.desfilter,tp,0,LOCATION_ONFIELD,nil,4-e:GetHandler():GetSequence())
	Duel.Destroy(g,REASON_EFFECT)
end
function c1009.limit(c)
	return	function (e,lp,tp)
	return   e:GetHandler()~=c
			end
end
function c1009.dmcon(e,tp,eg,ep,ev,re,r,rp)
    local ct=e:GetHandler():GetMaterialCount()
	return ct>=3 and ((e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget())
end
function c1009.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c1009.dmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c1009.incon(e)
	local ct=e:GetHandler():GetMaterialCount()
	return ct>=4
end
function c1009.intg(e,c)
	return c:IsSetCard(0x989) and not c:IsCode(1009)
end
function c1009.invalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end