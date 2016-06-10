--学徒型格尼妲
function c60150703.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	 
	--rh
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,6015703)
	e1:SetTarget(c60150703.target)
	e1:SetOperation(c60150703.activate)
	c:RegisterEffect(e1)
	--splimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c60150703.splimit)
	e3:SetCondition(c60150703.splimcon)
	c:RegisterEffect(e3)
	--summon with no tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60150703,1))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c60150703.ntcon)
	e2:SetOperation(c60150703.ntop)
	c:RegisterEffect(e2)
	--poh 
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(60150702,2))
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,60150703)
	e4:SetTarget(c60150703.target2)
	e4:SetOperation(c60150703.thop)
	c:RegisterEffect(e4)
end
function c60150703.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb22) or (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c60150703.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c60150703.filter(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c60150703.filter1(c,e)
	return c:IsFaceup() and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c60150703.filter2(c,e,tp,m,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x3b22) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
		and c:CheckFusionMaterial(m,nil,chkf)
end
function c60150703.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c60150703.filter,tp,LOCATION_EXTRA+LOCATION_HAND+LOCATION_ONFIELD,0,nil,e)
		local ct1=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
		local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
		if ct1<ct2 then
			local sg=Duel.GetMatchingGroup(c60150703.filter1,tp,LOCATION_EXTRA,0,nil,e)
			mg1:Merge(sg)
		end
		local res=Duel.IsExistingMatchingCard(c60150703.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				res=Duel.IsExistingMatchingCard(c60150703.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c60150703.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c60150703.filter,tp,LOCATION_EXTRA+LOCATION_HAND+LOCATION_ONFIELD,0,nil,e)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if ct1<ct2 then
		local sg=Duel.GetMatchingGroup(c60150703.filter1,tp,LOCATION_EXTRA,0,nil,e)
		mg1:Merge(sg)
	end
	local sg1=Duel.GetMatchingGroup(c60150703.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		sg2=Duel.GetMatchingGroup(c60150703.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			local tg=mat1:GetFirst()
			while tg do
				if tg:IsLocation(LOCATION_EXTRA) then
					Duel.SendtoGrave(tg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				else
					Duel.SendtoGrave(tg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				end
				tg=mat1:GetNext()
			end
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
	if Duel.SelectYesNo(tp,aux.Stringid(60150701,3)) then
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c60150703.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c60150703.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetValue(1900)
	c:RegisterEffect(e1)
end
function c60150703.filter4(c)
	return c:IsFaceup() or c:IsFacedown()
end
function c60150703.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60150703.filter4(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60150703.filter4,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c60150703.filter4,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c60150703.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() or tc:IsFacedown() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE+NO_FLIP_EFFECT)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,3)
		tc:RegisterEffect(e2)
	end
end