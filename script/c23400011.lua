--电气融合
function c23400011.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23400011+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c23400011.activate)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c23400011.desrepcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--extra summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e3:SetTarget(c23400011.extg)
	c:RegisterEffect(e3)
end
function c23400011.extg(e,c)
	return c:IsSetCard(0x530)
end
--
function c23400011.filter11(c)
	return c:IsFaceup() and c:IsCode(23400004)
end
function c23400011.desrepcon(e)
	return Duel.IsExistingMatchingCard(c23400011.filter11,e:GetHandler():GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
end
----
function c23400011.filter(c)
	return c:IsSetCard(0x530) and not c:IsCode(23400011) and c:IsAbleToHand()
end
function c23400011.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c23400011.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23400011,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
