--学徒型尼卡尔
function c60150705.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	 
	--pendulum set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,6015705)
	e1:SetCost(c60150705.cost)
	e1:SetTarget(c60150705.pctg)
	e1:SetOperation(c60150705.pcop)
	c:RegisterEffect(e1)
	--poh 
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(60150705,2))
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,60150705)
	e4:SetTarget(c60150705.sptg2)
	e4:SetOperation(c60150705.spop2)
	c:RegisterEffect(e4)
	--summon with no tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60150705,1))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c60150705.ntcon)
	e2:SetOperation(c60150705.ntop)
	c:RegisterEffect(e2)
	--splimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c60150705.splimit2)
	e3:SetCondition(c60150705.splimcon)
	c:RegisterEffect(e3)
end
function c60150705.cfilter(c,tp)
	return (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY) and c:IsType(TYPE_PENDULUM)) or (c:IsSetCard(0x3b22) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_PENDULUM)) and not (c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ))
end
function c60150705.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler())
	and Duel.GetCustomActivityCount(60150705,tp,ACTIVITY_SPSUMMON)==0 end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c60150705.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c60150705.splimit(e,c)
	return not ((c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) or c:IsSetCard(0xb22))
end
function c60150705.pctg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,13-seq)
		and Duel.IsExistingMatchingCard(c60150705.cfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,TYPE_PENDULUM) end
end
function c60150705.pcop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local seq=e:GetHandler():GetSequence()
	if not Duel.CheckLocation(tp,LOCATION_SZONE,13-seq) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c60150705.cfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,TYPE_PENDULUM)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	if Duel.SelectYesNo(tp,aux.Stringid(60150701,3)) then
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c60150705.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c60150705.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetValue(1900)
	c:RegisterEffect(e1)
end
function c60150705.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0) 
	return h1>=1 and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c60150705.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT) then Duel.BreakEffect()
		local c=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
	end
end 
function c60150705.splimit2(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb22) or (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c60150705.splimcon(e)
	return not e:GetHandler():IsForbidden()
end