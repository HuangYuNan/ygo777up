--Brood Sliver
require "expansions/script/c9990000"
function c9991806.initial_effect(c)
	Dazz.SliverCommonEffect(c,4,9991806)
end
c9991806.Dazz_name_sliver=true
function c9991806.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991806,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c9991806.condition)
	e1:SetTarget(c9991806.target)
	e1:SetOperation(c9991806.operation)
	c:RegisterEffect(e1)
end
function c9991806.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c9991806.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsHasEffect(9991806) and Duel.GetFlagEffect(tp,9991806)<2
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,9991800,0,0x5011,600,600,2,RACE_REPTILE,ATTRIBUTE_EARTH) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,9991806,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c9991806.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,9991800,0,0x5011,600,600,2,RACE_REPTILE,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,9991800)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	else
		return
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsPosition(POS_FACEUP_ATTACK) then return end
	Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991800,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end