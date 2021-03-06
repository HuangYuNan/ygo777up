--Syphon Sliver
require "expansions/script/c9990000"
function c9991804.initial_effect(c)
	Dazz.SliverCommonEffect(c,4,9991804)
end
c9991804.Dazz_name_sliver=true
function c9991804.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991804,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1)
	e1:SetCondition(c9991804.condition)
	e1:SetTarget(c9991804.target)
	e1:SetOperation(c9991804.operation)
	c:RegisterEffect(e1)
end
function c9991804.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c9991804.filter(c)
	return Dazz.IsSliver(c) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c9991804.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local val=Duel.GetMatchingGroupCount(c9991804.filter,tp,LOCATION_REMOVED,0,nil)*1000
	if chk==0 then return e:GetHandler():IsHasEffect(9991804) and Duel.GetFlagEffect(tp,9991804)<2 and val>0 end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,val)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,9991804,RESET_PHASE+PHASE_END,0,1)
end
function c9991804.operation(e,tp,eg,ep,ev,re,r,rp)
	local val1=Duel.GetMatchingGroupCount(c9991804.filter,tp,LOCATION_REMOVED,0,nil)*1000
	local val2=Duel.Damage(1-tp,val1,REASON_EFFECT)
	Duel.Recover(tp,val2,REASON_EFFECT)
end