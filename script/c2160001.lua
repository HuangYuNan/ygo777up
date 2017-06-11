if not BiDiu then require("script.c2160003")end
function c2160001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e,tp)return Duel.GetOverlayCount(tp,0,LOCATION_MZONE)>0 or Duel.GetMatchingGroup(fbidiu,tp,LOCATION_MZONE,0,nil):CheckWithSumGreater(Card.GetOverlayCount,1)end)
	e1:SetOperation(c2160001.op)
	c:RegisterEffect(e1)
	BiDiu(c)
end
function c2160001.op(e,tp)
	if not e:GetHandler():IsLocation(LOCATION_MZONE)then return end
	local g=Duel.GetOverlayGroup(tp,0,LOCATION_MZONE)
	local t=Duel.GetMatchingGroup(fbidiu,tp,LOCATION_MZONE,0,nil)
	local c=t:GetFirst()
	while c do
		g:Merge(c:GetOverlayGroup())
		c=t:GetNext()
	end
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)-g:GetCount()*800)
end