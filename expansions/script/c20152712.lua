--户冢彩加
function c20152712.initial_effect(c)
c:SetUniqueOnField(1,0,20152712)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(c20152712.xyzfilter),4,2)
	c:EnableReviveLimit()
		--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20152712.tgcost)
	e2:SetTarget(c20152712.tgtg)
	e2:SetOperation(c20152712.tgop)
	c:RegisterEffect(e2)
		--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152712,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c20152712.descon)
	e3:SetTarget(c20152712.destg)
	e3:SetOperation(c20152712.desop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e5)
end
function c20152712.xyzfilter(c)
	return c:IsSetCard(0xc290)
end

function c20152712.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152712.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_SZONE+LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,LOCATION_SZONE+LOCATION_HAND)
end
function c20152712.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,1-tp,LOCATION_SZONE+LOCATION_HAND,0,nil,TYPE_SPELL+TYPE_TRAP)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.SendtoGrave(sg,REASON_RULE)
	else
		local hg=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		Duel.ConfirmCards(tp,hg)
		Duel.ShuffleHand(1-tp)
	end
end
function c20152712.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c20152712.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c20152712.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
