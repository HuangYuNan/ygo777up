--ビート・ローレライ
require "expansions/script/c9990000"
function c9991013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,9991013+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c9991013.cost)
	e1:SetTarget(c9991013.target)
	e1:SetOperation(c9991013.activate)
	c:RegisterEffect(e1)
end
function c9991013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c9991013.filter1(c)
	return Dazz.IsVoid(c) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c9991013.filter2(c,e,tp)
	return Dazz.IsVoid(c) and Duel.IsExistingMatchingCard(c9991013.filter3,tp,LOCATION_EXTRA,0,1,c,c:GetCode(),e,tp) and c:IsAbleToRemoveAsCost()
end
function c9991013.filter3(c,code,e,tp)
	return aux.IsMaterialListCode(c,code) and Dazz.IsVoid(c) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c9991013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local noncost=e:GetLabel()~=100
	local v1,v2=
		(noncost or Duel.CheckLPCost(tp,800)) and Duel.IsExistingMatchingCard(c9991013.filter1,tp,0x41,0,1,nil)
			and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)),
		not noncost and Duel.IsExistingMatchingCard(c9991013.filter2,tp,LOCATION_MZONE,0,1,nil,e,tp)
	if chk==0 then return v1 or v2 end
	local lab,sel=0,0
	if v1 and v2 then
		if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and Duel.SelectYesNo(tp,aux.Stringid(9991013,3)) then
			sel=3 Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(9991013,4))
			else sel=Duel.SelectOption(tp,aux.Stringid(9991013,1),aux.Stringid(9991013,2))+1
		end
	elseif v1 and not v2 then sel=Duel.SelectOption(tp,aux.Stringid(9991013,1))+1
	elseif v2 and not v1 then sel=Duel.SelectOption(tp,aux.Stringid(9991013,2))+2
	end
	if sel~=2 then lab=lab+0x10000000 if not noncost then Duel.PayLPCost(tp,800) end end
	if sel~=1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rc=Duel.SelectMatchingCard(tp,c9991013.filter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
		lab=lab+rc:GetCode()
		Duel.Remove(rc,POS_FACEUP,REASON_COST)
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	end
	e:SetLabel(lab)
end
function c9991013.activate(e,tp,eg,ep,ev,re,r,rp)
	local lab=e:GetLabel()
	if bit.band(lab,0x10000000)==0x10000000 then
		lab=lab-0x10000000
		if Duel.IsExistingMatchingCard(c9991013.filter1,tp,0x41,0,1,nil)
			and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991013,0))
			local tc=Duel.SelectMatchingCard(tp,c9991013.filter1,tp,0x41,0,1,1,nil):GetFirst()
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c9991013.filter3,tp,LOCATION_EXTRA,0,1,nil,lab,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c9991013.filter3,tp,LOCATION_EXTRA,0,1,1,nil,lab,e,tp):GetFirst()
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
