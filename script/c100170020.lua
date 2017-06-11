--xunluoduizhang
function c100170020.initial_effect(c)
	--xyz
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x5cd),3,2)
	c:EnableReviveLimit()
	--cannot draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c100170020.con)
	c:RegisterEffect(e1)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c100170020.thcost)
	e3:SetTarget(c100170020.thtg)
	e3:SetOperation(c100170020.thop)
	c:RegisterEffect(e3)
end
function c100170020.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100170020.thfilter(c)
	return (c:IsType(TYPE_EQUIP) and c:IsType(TYPE_SPELL)) or (c:IsType(TYPE_MONSTER) and c:IsType(TYPE_UNION)) and c:IsAbleToHand()
end
function c100170020.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100170020.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c100170020.thop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100170020.thfilter,tp,LOCATION_GRAVE,0,nil)
	if sg and sg:GetCount()~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local rg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(rg)
		Duel.SendtoHand(rg,nil,REASON_EFFECT)
	end
end
function c100170020.con(e)
	return Duel.GetCurrentPhase()~=PHASE_DRAW
end