--ラクドスの鉄砲竜
function c9990202.initial_effect(c)
	--Fusion
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_DINOSAUR),aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),true)
	--Cannot be Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Extra Summon Rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(SUMMON_TYPE_FUSION)
	e2:SetCondition(c9990202.spcon)
	e2:SetOperation(c9990202.spop)
	c:RegisterEffect(e2)
	--Damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c9990202.target)
	e3:SetOperation(c9990202.operation)
	c:RegisterEffect(e3)
end
function c9990202.spfilter1(c,fc,tp)
	if tp and not Duel.IsExistingMatchingCard(c9990202.spfilter2,tp,LOCATION_MZONE,0,1,c) then return false end
	return c:IsRace(RACE_DINOSAUR) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToGraveAsCost()
end
function c9990202.spfilter2(c,fc,tp)
	if tp and not Duel.IsExistingMatchingCard(c9990202.spfilter1,tp,LOCATION_MZONE,0,1,c) then return false end
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToGraveAsCost()
end
function c9990202.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c9990202.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c9990202.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(c9990202.spfilter1,tp,LOCATION_MZONE,0,nil,c,tp)
	local g2=Duel.GetMatchingGroup(c9990202.spfilter2,tp,LOCATION_MZONE,0,nil,c,tp)
	local g3=Group.CreateGroup()
	g3:Merge(g1)
	g3:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg1=g3:Select(tp,1,1,nil)
	if sg1:GetFirst():IsAttribute(ATTRIBUTE_FIRE) and not sg1:GetFirst():IsRace(RACE_DINOSAUR) then g4=g1
		elseif not sg1:GetFirst():IsAttribute(ATTRIBUTE_FIRE) and sg1:GetFirst():IsRace(RACE_DINOSAUR) then g4=g2
		else g4=g3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg2=g4:Select(tp,1,1,sg1:GetFirst())
	sg1:Merge(sg2)
	c:SetMaterial(sg1)
	Duel.SendtoGrave(sg1,REASON_COST+REASON_MATERIAL+REASON_FUSION)
end
function c9990202.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local val=math.ceil(e:GetHandler():GetAttack()/2)
	if chk==0 then return val>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end
function c9990202.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER),math.ceil(c:GetAttack()/2)
	Duel.Damage(p,d,REASON_EFFECT)
end
