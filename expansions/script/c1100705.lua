--烦人的神明-诹访子
function c1100705.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,11007050)
	e1:SetCondition(c1100705.spcon)
	c:RegisterEffect(e1)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100705,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,1100705)
	e1:SetCondition(c1100705.descon)
	e1:SetCost(c1100705.descost)
	e1:SetTarget(c1100705.destg)
	e1:SetOperation(c1100705.desop)
	c:RegisterEffect(e1)
end
function c1100705.filter0(c)
	return c:IsFaceup() and c:GetLevel()==3 and c:IsAttribute(ATTRIBUTE_WATER) and not c:IsCode(1100705)
end
function c1100705.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100705.filter0,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c1100705.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3240) and c:IsType(TYPE_MONSTER)
end
function c1100705.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c1100705.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c1100705.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),c,nil,1,REASON_COST)
end
function c1100705.filter(c)
	 return c:IsSetCard(0x3240) and c:IsType(TYPE_MONSTER) and c:GetCode()~=1100705 and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c1100705.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100705.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c1100705.desop(e,tp,eg,ep,ev,re,r,rp)
   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1100705.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectYesNo(tp,aux.Stringid(1100705,1))) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
