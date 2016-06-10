--DRRR!! 园原杏里
function c80003002.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80003002,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,80003003)
	e1:SetCondition(c80003002.drcon)
	e1:SetTarget(c80003002.thtg)
	e1:SetOperation(c80003002.thop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80003002,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,80003003)
	e2:SetCondition(c80003002.descon)
	e2:SetTarget(c80003002.thtg)
	e2:SetOperation(c80003002.thop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80003002,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,80003002)
	e3:SetTarget(c80003002.sptg)
	e3:SetOperation(c80003002.spop)
	c:RegisterEffect(e3)  
	--cannot be material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(c80003002.splimit)
	c:RegisterEffect(e4)
	local e8=e4:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e8)
	local e7=e4:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e7)
end
function c80003002.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c80003002.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and (r==REASON_SYNCHRO or r==REASON_FUSION)
end
function c80003002.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x2da)
end
function c80003002.filter(c)
	return c:IsSetCard(0x2da) and c:IsAbleToHand() and not c:IsCode(80003002) and c:IsType(TYPE_MONSTER)
end
function c80003002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80003002.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80003002.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80003002.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end 
function c80003002.mfilter0(c)
	return c:IsCanBeFusionMaterial() and c:IsAbleToRemove()
end
function c80003002.mfilter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c80003002.mfilter2(c,e)
	return c:IsCanBeFusionMaterial() and c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c80003002.spfilter1(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsCode(80003014) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c80003002.spfilter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsCode(80003014) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c80003002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c80003002.spfilter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if res then return true end
		local mg2=Duel.GetMatchingGroup(c80003002.mfilter0,tp,LOCATION_GRAVE,0,nil)
		mg2:Merge(mg1)
		res=Duel.IsExistingMatchingCard(c80003002.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c80003002.spfilter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c80003002.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c80003002.mfilter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c80003002.spfilter1,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=Duel.GetMatchingGroup(c80003002.mfilter2,tp,LOCATION_GRAVE,0,nil,e)
	mg2:Merge(mg1)
	local sg2=Duel.GetMatchingGroup(c80003002.spfilter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,nil,chkf)
	sg1:Merge(sg2)
	local mg3=nil
	local sg3=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg3=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg3=Duel.GetMatchingGroup(c80003002.spfilter1,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg3~=nil and sg3:GetCount()>0) then
		local sg=sg1:Clone()
		if sg3 then sg:Merge(sg3) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg3==nil or not sg3:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			if tc:IsCode(17842364) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
				tc:SetMaterial(mat1)
				local mat2=mat1:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
				mat1:Sub(mat2)
				Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				Duel.Remove(mat2,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
				tc:SetMaterial(mat2)
				Duel.SendtoGrave(mat2,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			end
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat)
		end
		tc:CompleteProcedure()
	else
		local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
		local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
		local ct=cg1:GetCount()
		if not Duel.IsPlayerAffectedByEffect(tp,30459350) then
			ct=ct+Duel.GetMatchingGroupCount(c80003002.ctfilter,tp,LOCATION_GRAVE,0,nil)
		end
		if ct>1 and cg2:IsExists(Card.IsFacedown,1,nil)
			and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
			Duel.ConfirmCards(1-tp,cg1)
			Duel.ConfirmCards(1-tp,cg2)
			Duel.ShuffleHand(tp)
		end
	end
end
function c80003002.ctfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsCode(80003002)
end