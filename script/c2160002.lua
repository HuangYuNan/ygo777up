function BiDiu(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCost(BiDiuCo)
	e1:SetTarget(BiDiuTg)
	e1:SetOperation(BiDiuOp)
	c:RegisterEffect(e1)
end
function BiDiuCo(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost()end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function BiDiuTg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(fupBidiu,tp,LOCATION_MZONE,0,1,nil)and Duel.IsExistingMatchingCard(fssBidiu,tp,LOCATION_DECK,0,1,nil,e,tp)end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function fbidiu(c)
	local t=c:GetCode()
	return t>2159999 and t<2160013
end
function fupBidiu(c)return fbidiu(c)and c:IsFaceup()end
function fssbidiu(c,e,tp)
	return fbidiu(c)and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function fxyzbidiu(c)
	return fbidiu(c)and c:IsType(TYPE_XYZ)
end
function BiDiuOp(e,tp)
	local c=Duel.SelectMatchingCard(tp,fupBidiu,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local p=c:GetPosition()
	Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	Duel.SpecialSummon(Duel.SelectMatchingCard(tp,fssbidiu,tp,LOCATION_DECK,0,1,1,nil,e,tp),0,tp,tp,false,false,p)
end
if c2160002 and not c2160002.initial_effect then
	function c2160002.initial_effect(c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(true)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		c:RegisterEffect(e3)
		BiDiu(c)
	end
end