--来自伪装圣女的潜在幻想
function c18764001.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c18764001.xyzfilter,6,2)
	c:EnableReviveLimit()
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c18764001.efilter)
	c:RegisterEffect(e1)
	--change effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69840739,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c18764001.chcon)
	e2:SetCost(c18764001.cost)
	e2:SetTarget(c18764001.chtg)
	e2:SetOperation(c18764001.chop)
	c:RegisterEffect(e2)
end
function c18764001.xyzfilter(c)
	return c:IsSetCard(0xab0) or c:IsSetCard(0xabb)
end
function c18764001.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c18764001.chcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp
end
function c18764001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c18764001.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18764001.filter,rp,LOCATION_ONFIELD,0,1,nil)
and e:GetHandler():IsAbleToGrave() end
end
function c18764001.filter(c)
	return c:IsDestructable()
end
function c18764001.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c18764001.repop)
end
function c18764001.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP then
		c:CancelToGrave(false)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(1-tp,c18764001.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	end
end