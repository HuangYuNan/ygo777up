--new utakat
require "/expansions/script/c37564765"
function c37564303.initial_effect(c)
	senya.rxyz2(c,nil,nil,3)
	senya.mk(c,7,37564303,false)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c37564303.atktg)
	e1:SetOperation(c37564303.atkop)
	c:RegisterEffect(e1)
end 
function c37564303.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564303.rmfilter,tp,0,LOCATION_EXTRA,1,nil) end
end
function c37564303.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToChangeControler()
end
function c37564303.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c37564303.rmfilter,tp,0,LOCATION_EXTRA,nil)
	if g:GetCount()==0 then return end
	local gc=g:RandomSelect(tp,1):GetFirst()
	for i=0,3 do
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564303,i))
	end
	Duel.Overlay(c,Group.FromCards(gc))
	if c:GetOverlayGroup():IsContains(gc) then
		senya.copy(e,nil,gc,true)
	end
end