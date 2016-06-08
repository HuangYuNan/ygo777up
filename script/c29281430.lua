--ゴーストリック・アルカード
function c29281430.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3da),4,2)
	c:EnableReviveLimit()
	--confiem
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29281430,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,29281430)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c29281430.cost)
	e2:SetTarget(c29281430.target)
	e2:SetOperation(c29281430.operation)
	c:RegisterEffect(e2)
	--sort
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,29281431)
	e3:SetCondition(c29281430.sdcon)
	e3:SetTarget(c29281430.sdtg)
	e3:SetOperation(c29281430.sdop)
	c:RegisterEffect(e3)
end
function c29281430.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29281430.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
end
function c29281430.filter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281430.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	local ct=g:FilterCount(c29281430.filter,nil)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if ct>0 and sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=sg:Select(tp,1,ct,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.BreakEffect()
	end
		Duel.SortDecktop(tp,tp,5)
		for i=1,5 do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
		end
end
function c29281430.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c29281430.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c29281430.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
