if not BiDiu then require("script.c2160003")end
function c2160000.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e)return Duel.IsExistingMatchingCard(function(c)return c:IsPosition(POS_FACEUP_ATTACK)and not c:IsImmuneToEffect(e) end,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())end)
	e1:SetOperation(c2160000.op)
	c:RegisterEffect(e1)
	BiDiu(c)
end
function c2160000.op(e,tp)
	local g=Duel.GetMatchingGroup(function(c)return c:IsPosition(POS_FACEUP_ATTACK)and not c:IsImmuneToEffect(e)end,0,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+RESET_TURN_SET+RESET_LEAVE+RESET_PHASE+PHASE_END,Duel.GetTurnPlayer()==tp and 1 or 2)
	local c=g:GetFirst()
	c:RegisterEffect(e1)
	c=g:GetNext()
	while c do
		e1=e1:Clone()
		c:RegisterEffect(e1)
		c=g:GetNext()
	end
end
