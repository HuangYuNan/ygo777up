--蜜蚁爱愉
function c10953622.initial_effect(c)
	c:EnableReviveLimit()
	--xyz_summon 
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10953622.spcon)
	e0:SetOperation(c10953622.spop)
	e0:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e0)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c10953622.cost)
	e1:SetTarget(c10953622.target)
	e1:SetOperation(c10953622.activate)
	c:RegisterEffect(e1)
	--remove overlay replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10953622,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(2)
	e2:SetCondition(c10953622.rcon)
	e2:SetOperation(c10953622.rop)
	c:RegisterEffect(e2)
	--draw  
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c10953622.drcon)
	e3:SetTarget(c10953622.destg)
	e3:SetOperation(c10953622.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10953622,0))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,10953622)
	e4:SetCost(c10953622.ctcon)
	e4:SetTarget(c10953622.cttg)
	e4:SetOperation(c10953622.ctop)
	c:RegisterEffect(e4)
end
function c10953622.ovfilter(c,g)
	return c:IsSetCard(0x350) and c:IsFaceup() and not c:IsType(TYPE_XYZ) and not c:IsType(TYPE_TUNER) and c:IsCanBeXyzMaterial(g) and not c:IsType(TYPE_TOKEN)
end
function c10953622.spcon(e,c)
	if  Duel.IsExistingMatchingCard(c10953622.ovfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,2,nil,e:GetHandler()) then return true
	else return false end
end
function c10953622.spop(e,tp,eg,ep,ev,re,r,rp,c) 
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c10953622.ovfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,2,2,nil,e:GetHandler())
	if g:GetCount()==2  then
	Duel.Overlay(c,g)
end
end
function c10953622.rcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(10953622+ep)==0
		and bit.band(r,REASON_COST)~=0 and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_XYZ)
		and re:GetHandler():GetOverlayCount()>=ev-1
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,nil)
end
function c10953622.rop(e,tp,eg,ep,ev,re,r,rp)
	local ct=bit.band(ev,0xffff)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct>1 then
		re:GetHandler():RemoveOverlayCard(tp,ct-1,ct-1,REASON_COST)
	end
	e:GetHandler():RegisterFlagEffect(10953622+ep,RESET_PHASE+PHASE_END,0,1)
end
function c10953622.disfilter2(c)
	return c:IsCode(5012604) and c:IsFaceup()
end
function c10953622.drcon(e,tp,eg,ep,ev,re,r,rp)
	 return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ 
	and Duel.IsExistingMatchingCard(c10953622.disfilter2,tp,LOCATION_ONFIELD,0,1,nil) 
end
function c10953622.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c10953622.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10953622.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c10953622.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10953622.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c10953622.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c10953622.ctcon(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c10953622.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,0)
end
function c10953622.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(1-tp,Card.IsAbleToChangeControler,1-tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	if not Duel.GetControl(tc,tp) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
function c10953622.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c10953622.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c10953622.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c10953622.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c10953622.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c10953622.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c10953622.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c10953622.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c10953622.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c10953622.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
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
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	else
		local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
		local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
		if cg1:GetCount()>1 and cg2:IsExists(Card.IsFacedown,1,nil)
			and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
			Duel.ConfirmCards(1-tp,cg1)
			Duel.ConfirmCards(1-tp,cg2)
			Duel.ShuffleHand(tp)
		end
	end
end