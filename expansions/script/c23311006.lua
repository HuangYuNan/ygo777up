--混沌之龙王
function c23311006.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local ef=Effect.CreateEffect(c)
	ef:SetType(EFFECT_TYPE_SINGLE)
	ef:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ef:SetCode(EFFECT_FUSION_MATERIAL)
	ef:SetCondition(c23311006.fscondition)
	ef:SetOperation(c23311006.fsoperation)
	c:RegisterEffect(ef)
	--spsummon condition
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ex:SetCode(EFFECT_SPSUMMON_CONDITION)
	ex:SetValue(c23311006.splimit)
	c:RegisterEffect(ex)
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c23311006.sprcon)
	e0:SetOperation(c23311006.sprop)
	c:RegisterEffect(e0)
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23311006,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c23311006.con)
	e1:SetTarget(c23311006.mttg)
	e1:SetOperation(c23311006.mtop)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c23311006.con)
	e2:SetValue(1)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	--Attribute Dark
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_ADD_ATTRIBUTE)
	e5:SetCondition(c23311006.con)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(ATTRIBUTE_DARK)
	e5:SetLabel(1)
	c:RegisterEffect(e5)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23311006,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c23311006.discon)
	e3:SetCost(c23311006.discost)
	e3:SetTarget(c23311006.distg)
	e3:SetOperation(c23311006.disop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23311006,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCondition(c23311006.spcon)
	e4:SetCost(c23311006.spcost)
	e4:SetTarget(c23311006.sptg)
	e4:SetOperation(c23311006.spop)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e4)
end
function c23311006.ffilter(c,fc)
	return c:IsType(TYPE_PENDULUM) and c:IsCanBeFusionMaterial(fc)
end
function c23311006.fscondition(e,g,gc)
	if g==nil then return true end
	if gc then return false end
	return g:IsExists(c23311006.ffilter,3,nil)
end
function c23311006.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	Duel.SetFusionMaterial(eg:FilterSelect(tp,c23311006.ffilter,3,99,nil))
end
function c23311006.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION or e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c23311006.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.CheckReleaseGroup(tp,c23311006.ffilter,3,nil,c)
end
function c23311006.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c23311006.ffilter,3,99,nil,c)
	Duel.Release(g,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c23311006.con(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311001) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311002) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311003) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311004) then ct=ct+1 end
	return ct>e:GetLabel()
end
function c23311006.tgfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToDeck()
end
function c23311006.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return tp==Duel.GetTurnPlayer() 
		and Duel.IsExistingMatchingCard(c23311006.tgfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c23311006.mtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c23311006.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c23311006.discon(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311001) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311002) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311003) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311004) then ct=ct+1 end
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and ct>2
end
function c23311006.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToDeckAsCost()
end
function c23311006.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23311006.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c23311006.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c23311006.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c23311006.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function c23311006.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311001) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311002) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311003) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,23311004) then ct=ct+1 end
	return ct>3
end
function c23311006.filter(c,e,tp)
	return c:GetLevel()>3 and Duel.IsExistingMatchingCard(c23311006.cfilter,tp,LOCATION_GRAVE,0,c:GetLevel()-3,nil)
		and c:IsType(TYPE_FUSION) and e:GetHandler():IsAbleToGrave() and c:CheckFusionMaterial()
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c23311006.filter1(c,e,tp,i)
	return c:GetLevel()==i and e:GetHandler():IsAbleToGrave() and c:IsType(TYPE_FUSION) and c:CheckFusionMaterial()
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c23311006.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c23311006.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local oc=Duel.GetMatchingGroupCount(c23311006.cfilter,tp,LOCATION_GRAVE,0,nil)
	local t={}
	local i=1
	local p=1
	for i=1,oc do 
		if Duel.IsExistingMatchingCard(c23311006.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,i+3) then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23311006,3))
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
	local g=Duel.SelectMatchingCard(tp,c23311006.cfilter,tp,LOCATION_GRAVE,0,e:GetLabel(),e:GetLabel(),nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c23311006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23311006.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23311006.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.SendtoGrave(c,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23311006.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel()+3)
	local tc=g:GetFirst()
	if not tc then return end
	tc:SetMaterial(nil)
	Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
end