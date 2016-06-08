--琪露诺：你是笨蛋么？
function c74010013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetTarget(c74010013.target)
	e1:SetOperation(c74010013.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c74010013.handcon)
	c:RegisterEffect(e2)
	--salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74010013,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,74010013)
	e3:SetCondition(c74010013.rcon)
	e3:SetCost(c74010013.cost)
	e3:SetTarget(c74010013.target2)
	e3:SetOperation(c74010013.operation2)
	c:RegisterEffect(e3)
end
c74010013.list={[74010005]=74010008,[74010006]=74010009,[74010007]=74010010}
function c74010013.filter2(c)
	return c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3740)
end
function c74010013.filter(c)
	return c:IsAbleToGrave() and c:IsSetCard(0x3740)
end
function c74010013.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c74010013.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c74010013.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c74010013.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local mg=Duel.GetMatchingGroup(c74010013.filter2,tp,LOCATION_GRAVE,0,nil)
		if mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(74010013,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			if sg:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then return end
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
function c74010013.hdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x3740)
end
function c74010013.handcon(e)
	return not Duel.IsExistingMatchingCard(c74010013.hdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c74010013.rfilter(c)
	return not (c:IsSetCard(0x3740) and c:IsType(TYPE_MONSTER))
end
function c74010013.rcon(e)
	return not Duel.IsExistingMatchingCard(c74010013.rfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c74010013.filter1(c,e,tp)
    local code=c:GetCode()
	local tcode=c74010013.list[code]
	return tcode and bit.band(c:GetType(),0x82)==0x82 and c:IsSetCard(0x3740) and c:IsAbleToRemoveAsCost()
	and Duel.IsExistingMatchingCard(c74010013.filter3,tp,LOCATION_HAND,0,1,nil,tcode,e,tp)
end
function c74010013.filter3(c,tcode,e,tp)
	return c:IsCode(tcode) --and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c74010013.cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    e:SetLabel(1)
	return true
end
function c74010013.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c74010013.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp)
			and e:GetHandler():IsAbleToRemoveAsCost()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c74010013.filter1,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	e:SetLabel(g:GetFirst():GetCode())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c74010013.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=e:GetLabel()
	local tcode=c74010013.list[code]
	local tc=Duel.GetFirstMatchingCard(c74010013.filter3,tp,LOCATION_HAND,0,nil,tcode,e,tp)
	if tc and Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	--cannot set
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SSET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	Duel.RegisterEffect(e3,tp)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetTarget(c74010013.sumlimit)
	Duel.RegisterEffect(e4,tp)
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetTarget(c74010013.splimit)
	e5:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e5,tp)
	end
end
function c74010013.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x3740)
end
function c74010013.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)~=0
end