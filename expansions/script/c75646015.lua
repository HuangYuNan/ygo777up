--Master Chief
function c75646015.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c75646015.xyzcon)
	e1:SetOperation(c75646015.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c75646015.atkval)
	c:RegisterEffect(e2)
	--place
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c75646015.cost)
	e3:SetTarget(c75646015.target)
	e3:SetOperation(c75646015.operation)
	c:RegisterEffect(e3)
	--activate limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_ONFIELD)
	e4:SetTargetRange(0,1)
	e4:SetCondition(c75646015.condition)
	e4:SetValue(c75646015.aclimit)
	c:RegisterEffect(e4)
	--Remove
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
	end)
	e5:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e5)
end
function c75646015.mfilter(c,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x2c1) and c:GetOverlayCount()>0 and c:IsCanBeXyzMaterial(xyzc)
end
function c75646015.xyzfilter1(c,g,ct)
	return g:IsExists(c75646015.xyzfilter2,ct,c,c:GetRank())
end
function c75646015.xyzfilter2(c,rk)
	return c:GetRank()==4
end
function c75646015.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local minc=2
	local maxc=2
	if min then
		minc=math.max(minc,min)
		maxc=max
	end
	local ct=math.max(minc-1,-ft)
	local mg=nil
	if og then
		mg=og:Filter(c75646015.mfilter,nil,c)
	else
		mg=Duel.GetMatchingGroup(c75646015.mfilter,tp,LOCATION_MZONE,0,nil,c)
	end
	return maxc>=2 and mg:IsExists(c75646015.xyzfilter1,1,nil,mg,ct)
end
function c75646015.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	if og and not min then
		g=og
	else
		local mg=nil
		if og then
			mg=og:Filter(c75646015.mfilter,nil,c)
		else
			mg=Duel.GetMatchingGroup(c75646015.mfilter,tp,LOCATION_MZONE,0,nil,c)
		end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local minc=2
		local maxc=2
		if min then
			minc=math.max(minc,min)
			maxc=max
		end
		local ct=math.max(minc-1,-ft)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,c75646015.xyzfilter1,1,1,nil,mg,ct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,c75646015.xyzfilter2,ct,maxc-1,g:GetFirst(),g:GetFirst():GetRank())
		g:Merge(g2)
	end
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		sg:Merge(tc:GetOverlayGroup())
		tc=g:GetNext()
	end
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c75646015.atkval(e,c)
	return Duel.GetOverlayCount(c:GetControler(),LOCATION_MZONE,1)*500
end
function c75646015.condition(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c75646015.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e)
end
function c75646015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75646015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK,0,1,nil,0x2c1)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c75646015.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,0x2c1)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(tc)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
		Duel.RaiseEvent(tc,75646008,e,0,tp,0,0)
	end
end