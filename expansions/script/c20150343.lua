--第二精靈•嗫告篇帙
function c20150343.initial_effect(c)
	c:SetUniqueOnField(1,0,20150343)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3291),2,2)
	c:EnableReviveLimit()
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150343,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,20150343)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c20150343.cost)
	e1:SetTarget(c20150343.target)
	e1:SetOperation(c20150343.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e2)
	--confirm deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20150343,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetCondition(c20150343.cfcon)
	e3:SetOperation(c20150343.cfop)
	c:RegisterEffect(e3)
end
function c20150343.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150343.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20150343,4))
	e:SetLabel(Duel.SelectOption(tp,70,71,72))
end
function c20150343.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	if e:GetLabel()==0 then
		e1:SetValue(c20150343.aclimit1)
	elseif e:GetLabel()==1 then
		e1:SetValue(c20150343.aclimit2)
	else e1:SetValue(c20150343.aclimit3) end
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e1,tp)
end
function c20150343.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e)
end
function c20150343.aclimit2(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and not re:GetHandler():IsImmuneToEffect(e)
end
function c20150343.aclimit3(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP) and not re:GetHandler():IsImmuneToEffect(e)
end
function c20150343.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>0
end
function c20150343.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,1)
	Duel.ConfirmCards(tp,g)
	local tc=g:GetFirst()
	local opt=Duel.SelectOption(tp,aux.Stringid(20150343,2),aux.Stringid(20150343,3))
	if opt==1 then
		Duel.MoveSequence(tc,opt)
	end
end
