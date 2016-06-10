--神之曲 灵升者米萨提波
function c75000045.initial_effect(c)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c75000045.splimit)
	c:RegisterEffect(e0)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c75000045.spcon)
	e3:SetTarget(c75000045.sptg)
	e3:SetOperation(c75000045.spop)
	c:RegisterEffect(e3)
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
   -- e4:SetRange(LOCATION_MZONE)
	--e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	--e4:SetCondition(c75000045.indcon)
	--e4:SetValue(1)
	--c:RegisterEffect(e4)
	--local e8=e4:Clone()
	--e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	--c:RegisterEffect(e8)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetCode(EVENT_REMOVE)
	e5:SetCondition(c75000045.con)
	e5:SetTarget(c75000045.tg)
	e5:SetOperation(c75000045.op)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_TO_GRAVE)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e7)
end
function c75000045.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(75000045)
end
function c75000045.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and not c:IsType(TYPE_TOKEN) and (c:IsType(TYPE_MONSTER) or c:IsType(TYPE_PENDULUM))
end
function c75000045.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75000045.cfilter,1,nil,tp)
end
function c75000045.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c75000045.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,75000046,0x52f,0x4011,-2,-2,7,RACE_ZOMBIE,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,75000046)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(c75000045.val)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		token:RegisterEffect(e2,true)
	end
	Duel.SelectOption(1-tp,aux.Stringid(75000045,0))
end
function c75000045.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,e:GetHandler():GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil,75000046)*1250
end
function c75000045.indcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,nil,75000046)
end
function c75000045.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c75000045.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,75000046) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c75000045.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,75000046)
	if tc:GetCount()>0 then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end