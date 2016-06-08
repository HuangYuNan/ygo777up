--调乐师
function c233648.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c233648.atktg)
	e1:SetOperation(c233648.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition(function() return Duel.GetTurnPlayer()==c:GetControler() end)
    e2:SetTarget(c233648.sptg)
	e2:SetOperation(c233648.spop)
    c:RegisterEffect(e2)
end	
function c233648.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,0x4,1,nil) end
end
function c233648.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0x4,0,nil)
	local ct=Duel.GetMatchingGroupCount(aux.TRUE,tp,0,0x4,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	local tc=g:GetFirst()
	    while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end	
end
function c233648.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0 and Duel.IsExistingTarget(aux.TRUE,tp,0x4,0,1,nil)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c233648.spop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0x4,0,e:GetHandler())
	if  Duel.Destroy(g,0x40)>0  then
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,0x8)
	end
end