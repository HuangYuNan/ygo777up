--玉符「众神的光辉弹冠」
function c1103016.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk/def down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(c1103016.atktg)
	e3:SetValue(c1103016.atkval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4) 
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(1103016,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,1103016)
	e3:SetCost(c1103016.cost)
	e3:SetTarget(c1103016.target)
	e3:SetOperation(c1103016.operation)
	c:RegisterEffect(e3)
end
function c1103016.atktg(e,c)
	return not c:IsSetCard(0xa240)
end
function c1103016.vfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa240)
end
function c1103016.atkval(e,c)
	return Duel.GetMatchingGroupCount(c1103016.vfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*-200
end
function c1103016.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa240) and c:IsAbleToGraveAsCost()
end
function c1103016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c1103016.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c1103016.cfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c1103016.filter(c,e,tp)
	return (c:IsLocation(LOCATION_HAND+LOCATION_DECK) and c:IsSetCard(0xa240) and c:IsRace(RACE_FAIRY)) or (c:IsType(TYPE_SYNCHRO) and c:IsSetCard(0xa240))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1103016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1103016.filter,tp,0x43,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x43)
end
function c1103016.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1103016.filter,tp,0x43,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

