--Manaweft Sliver
require "expansions/script/c9990000"
function c9991807.initial_effect(c)
	Dazz.SliverCommonEffect(c,4,9991807)
end
c9991807.Dazz_name_sliver=true
function c9991807.Sliver_General_Effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991807,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c9991807.condition)
	e1:SetTarget(c9991807.target)
	e1:SetOperation(c9991807.operation)
	c:RegisterEffect(e1)
end
function c9991807.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c9991807.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsHasEffect(9991807) and Duel.GetFlagEffect(tp,9991807)<2
		and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,9991807,RESET_PHASE+PHASE_END,0,1)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c9991807.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==0 then return end
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