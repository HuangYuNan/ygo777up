--魔法的骤雨  鹿目圆香
function c1000616.initial_effect(c)
   --synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xc204),aux.NonTuner(Card.IsSetCard,0xc204),1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c1000616.con)
	e1:SetCountLimit(1,1000616)
	e1:SetTarget(c1000616.sptg)
	e1:SetOperation(c1000616.spop)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c1000616.con2)
	e2:SetValue(c1000616.efilter)
	c:RegisterEffect(e2)
	--atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c1000616.con3)
	e2:SetCondition(c1000616.valcon)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c1000616.con(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,0xc204)
	local ct=g:GetClassCount(Card.GetCode)
   return  ct>=9
end
function c1000616.spfilter(c,e,tp)
	return c:IsLevelAbove(5) and c:IsSetCard(0xc204) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1000616.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c1000616.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1000616.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1000616.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1000616.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1000616.con2(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,0xc204)
	local ct=g:GetClassCount(Card.GetCode)
   return  ct>=3
end
function c1000616.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
function c1000616.con3(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,0xc204)
	local ct=g:GetClassCount(Card.GetCode)
   return  ct>=6
end
function c1000616.vfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc204)
end
function c1000616.valcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c1000616.vfilter,c:GetControler(),LOCATION_MZONE,0,1,c)
end