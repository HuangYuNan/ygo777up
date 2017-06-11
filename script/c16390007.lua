--圣域十二宫
function c16390007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x163))
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--defup
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3) 
	--replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c16390007.indtg)
	e4:SetValue(c16390007.indval)
	c:RegisterEffect(e4) 
	--change lp
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(16390007,1))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCost(c16390007.cost2)
	e5:SetOperation(c16390007.lpop)
	c:RegisterEffect(e5)  
end
function c16390007.indfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsSetCard(0x163)
end
function c16390007.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c16390007.indfilter,1,nil,tp) end
	return true
end
function c16390007.indval(e,c)
	return c16390007.indfilter(c,e:GetHandlerPlayer())
end
function c16390007.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,12000)
	Duel.SetLP(1-tp,12)
end
function c16390007.cfilter(c)
	return c:IsSetCard(0x163) and c:IsAbleToRemoveAsCost() and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c16390007.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c16390007.cfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,nil)
	if chk==0 then return g:GetClassCount(Card.GetCode)>=12 end
	local rg=Group.CreateGroup()
	for i=1,12 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		if tc then
			rg:AddCard(tc)
			g:Remove(Card.IsCode,nil,tc:GetCode())
		end
	end
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end