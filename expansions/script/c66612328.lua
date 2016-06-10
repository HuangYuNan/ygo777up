--扑克少女·白骑士爱丽丝
function c66612328.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66612328,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,66612328)
	e1:SetTarget(c66612328.target)
	e1:SetOperation(c66612328.operation)
	c:RegisterEffect(e1)
	--diratk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c66612328.dircon)
	c:RegisterEffect(e3)
end
function c66612328.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x666) or c:IsSetCard(0x660))
end
function c66612328.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66612328.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c66612328.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66612328,1))
	Duel.SelectTarget(tp,c66612328.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c66612328.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(2)
	tc:RegisterEffect(e1)
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66612328.cfilter(c)
	return c:IsFaceup() and c:IsCode(19910004)
end
function c66612328.dircon(e)
	return Duel.IsExistingMatchingCard(c66612328.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end