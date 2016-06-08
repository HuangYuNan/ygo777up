--黑塔·八页法师·露露缇雅·泽金
function c10958000.initial_effect(c)
	c:EnableUnsummonable()
	c:SetUniqueOnField(1,0,10958000)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10958000,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c10958000.spcon)
	e1:SetCost(c10958000.spcost)
	e1:SetTarget(c10958000.sptg)
	e1:SetOperation(c10958000.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c10958000.rmtarget)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(10958000)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTargetRange(0xff,0xff)
	e3:SetTarget(c10958000.checktg)
	c:RegisterEffect(e3)
	--Attribute Dark
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_RACE)
	e4:SetRange(LOCATION_MZONE+LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
	e4:SetValue(RACE_FAIRY)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c10958000.value)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c10958000.efilter)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_IMMUNE_EFFECT)
	e7:SetValue(c10958000.efilter2)
	c:RegisterEffect(e7) 
	--spsummon limit
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SPSUMMON_CONDITION)
	e8:SetValue(c10958000.splimit)
	c:RegisterEffect(e8)
	--inactivatable
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_INACTIVATE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(c10958000.effectfilter)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CANNOT_DISEFFECT)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c10958000.effectfilter)
	c:RegisterEffect(e10)
	--destroy replace
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EFFECT_DESTROY_REPLACE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetTarget(c10958000.reptg)
	e11:SetValue(c10958000.repval)
	c:RegisterEffect(e11)
	--special summon
	local e13=Effect.CreateEffect(c)
	e13:SetDescription(aux.Stringid(10958000,1))
	e13:SetCategory(CATEGORY_REMOVE)
	e13:SetType(EFFECT_TYPE_IGNITION)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCountLimit(1)
	e13:SetCost(c10958000.rmcost)
	e13:SetTarget(c10958000.rmtg)
	e13:SetOperation(c10958000.rmop)
	c:RegisterEffect(e13)
end
function c10958000.spcon(e,c)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)==0 
end
function c10958000.cfilter(c)
	return c:IsSetCard(0x236) and c:IsType(TYPE_MONSTER)
end
function c10958000.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c10958000.cfilter,3,nil) end
	local g=Duel.SelectReleaseGroup(tp,c10958000.cfilter,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c10958000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10958000.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10958000.filter3(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c10958000.value(e,c)
	return Duel.GetMatchingGroupCount(c10958000.filter3,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*300
end
function c10958000.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL) and not te:IsActiveType(TYPE_FIELD)
end
function c10958000.efilter2(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
function c10958000.splimit(e,se,sp,st)
	return not se:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP)
end
function c10958000.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	local tc=te:GetHandler()
	return p==tp and tc:IsType(TYPE_SPELL)
end
function c10958000.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0x236) and c:IsLevelBelow(8) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c10958000.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c10958000.repfilter,nil,tp)
	local g=Duel.GetDecktopGroup(tp,ct)
	if chk==0 then return g:IsExists(Card.IsAbleToRemove,ct,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(10958000,0)) then
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		return true
	else return false end
end
function c10958000.repval(e,c)
	return c10958000.repfilter(c,e:GetHandlerPlayer())
end
function c10958000.rmtarget(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c10958000.checktg(e,c)
	return not c:IsPublic()
end
function c10958000.rmfilter(c)
	return c:IsAbleToDeckAsCost()
end
function c10958000.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10958000.spfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c10958000.rmfilter,tp,LOCATION_REMOVED,0,8,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c10958000.rmfilter,tp,LOCATION_REMOVED,0,8,8,nil)
	Duel.SendtoDeck(g,nil,8,REASON_COST)
end
function c10958000.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,PLAYER_ALL,LOCATION_DECK)
end
function c10958000.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetDecktopGroup(tp,2)
	local g2=Duel.GetDecktopGroup(1-tp,2)
	g1:Merge(g2)
	Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end