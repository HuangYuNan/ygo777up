Dazz=Dazz or {}

--Counter list
--[[!counter 0x1220 忠诚指示物 (Was 0x2c)]]

math.randomseed(require "os".time())

function Dazz.ExileCard(tc)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1,true)
	local t={EFFECT_CANNOT_TO_DECK,EFFECT_CANNOT_REMOVE,EFFECT_CANNOT_TO_GRAVE}
	for i,code in pairs(t) do
		local ex=e1:Clone()
		ex:SetCode(code)
		tc:RegisterEffect(ex,true)
	end
	Duel.SendtoGrave(tc:GetOverlayGroup(),REASON_RULE)
	Duel.SendtoDeck(tc,nil,-1,REASON_RULE)
	tc:ResetEffect(0xfff0000,RESET_EVENT)
end

--[[function Dazz.ExileGroup(eg)
	local gg=Group.CreateGroup()
	eg:ForEach(function(tc)
		gg:Merge(tc:GetOverlayGroup())
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TO_HAND)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local t={EFFECT_CANNOT_TO_DECK,EFFECT_CANNOT_REMOVE,EFFECT_CANNOT_TO_GRAVE}
		for i,code in pairs(t) do
			local ex=e1:Clone()
			ex:SetCode(code)
			tc:RegisterEffect(ex,true)
		end
	end)
	Duel.SendtoGrave(gg,REASON_RULE)
	Duel.SendtoDeck(eg,nil,-1,REASON_RULE)
	eg:ForEach(function(tc)
		tc:ResetEffect(0xfff0000,RESET_EVENT)
	end)
end]]

--Double-faced Card
function Dazz.DFCFrontsideCommonEffect(c)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	Dazz.EnableDFCGlobalCheck(c)
	local code=c:GetOriginalCode()
	local m=_G["c"..code]
	if not m.Dazz_DFC_Paramater then
		m.Dazz_DFC_Paramater={0,code+1}
	end
end
function Dazz.DFCBacksideCommonEffect(c)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	Dazz.EnableDFCGlobalCheck(c)
	local code=c:GetOriginalCode()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_ADD_CODE)
	e1:SetValue(code)
	c:RegisterEffect(e1)
	local m=_G["c"..code]
	if not m.Dazz_DFC_Paramater then
		m.Dazz_DFC_Paramater={1,code-1}
	end
end
function Dazz.EnableDFCGlobalCheck(c)
	if not Dazz.Transform_set then
		--create and keep couples of frontsides and backsides
		Dazz.Transform_set={}
		Dazz.DFCStackSet=Group.CreateGroup()
		Dazz.DFCStackSet:KeepAlive()
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetCode(EVENT_ADJUST)
		ex:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
			return Dazz.DFCStackSet:GetCount()>=0
		end)
		ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local tc=Dazz.DFCStackSet:GetFirst()
			while tc do
				local token=Dazz.Transform_set[tc]
				if not token then
					token=Duel.CreateToken(tc:GetOwner(),tc.Dazz_DFC_Paramater[2])
					Dazz.Transform_set[tc]=token
					Dazz.Transform_set[token]=tc
				end
				tc=Dazz.DFCStackSet:GetNext()
			end
			Dazz.DFCStackSet:Clear()
		end)
		Duel.RegisterEffect(ex,0)
		--check whether backsides need to turn back to frontsides
		Dazz.DFC_turn_filter=function(c)
			if c:IsLocation(LOCATION_EXTRA) and c:IsFaceup() then return false end
			if c:IsLocation(LOCATION_REMOVED) and c:IsFacedown() then return false end
			local t=c.Dazz_DFC_Paramater
			return t and t[1]==1
		end
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local ug=Duel.GetFieldGroup(i,0x73,0x73):Filter(Dazz.DFC_turn_filter,nil)
			local tg=Group.CreateGroup()
			if ug:GetCount()~=0 then
				local tc=ug:GetFirst()
				local sfd,sfh={[0]=false,[1]=false},{[0]=false,[1]=false}
				while tc do
					local loc=tc:GetLocation()
					local fu=tc:IsFaceup()
					local controller=tc:GetControler()
					local token=Dazz.DFCTransformExecute(tc)
					tg:AddCard(token)
					if loc==LOCATION_DECK then
						Duel.SendtoDeck(token,controller,2,REASON_RULE)
						sfd[controller]=true
					elseif loc==LOCATION_HAND then
						Duel.SendtoHand(token,controller,REASON_RULE)
						sfh[controller]=true
					elseif loc==LOCATION_GRAVE then
						Duel.SendtoGrave(token,REASON_RULE)
					elseif loc==LOCATION_REMOVED then
						--don't turn back when removed face-down
						Duel.Remove(token,POS_FACEUP,REASON_RULE)
					elseif loc==LOCATION_EXTRA then
						--don't turn back when extra face-up
						Duel.SendtoDeck(token,controller,0,REASON_RULE)
					end
					tc=ug:GetNext()
				end
				for i=0,1 do
					if sfd[i]==true then Duel.ShuffleDeck(i) end
					if sfh[i]==true then Duel.ShuffleHand(i) end
				end
			end
		end)
		Duel.RegisterEffect(e1,0)
		local t={EVENT_ADJUST}
		for i,code in pairs(t) do
			local ex=e1:Clone()
			ex:SetCode(code)
			Duel.RegisterEffect(ex,0)
		end
	end
	Dazz.DFCStackSet:AddCard(c)
end
--[[This function tells you whether "sp_player" can special summon the transform target.
	If "sp_player" is nill or transform target isn't a monster, tells whether it's a double-faced. 
	"..." provides extra paramaters for Duel.IsPlayerCanSpecialSummonMonster.]]
function Dazz.DFCTransformable(c,sp_player,...)
	local param=c.Dazz_DFC_Paramater
	if not param then return false end
	if not sp_player then return true end
	local token=Dazz.Transform_set[c]
	if not token:IsType(TYPE_MONSTER) then return true end
	return Duel.IsPlayerCanSpecialSummonMonster(sp_player,token:GetOriginalCode(),0,
		token:GetOriginalType(),token:GetTextAttack(),token:GetTextDefense(),
		math.max(token:GetOriginalLevel(),token:GetOriginalRank()),token:GetOriginalRace(),
		token:GetOriginalAttribute(),...)
end
--[[This function executes double-faced card "c" transforming.]]
function Dazz.DFCTransformExecute(c,proc_complete)
	if not c.Dazz_DFC_Paramater then return false end
	Dazz.ExileCard(c)
	local token=Dazz.Transform_set[c]
	if proc_complete and token:IsHasEffect(EFFECT_REVIVE_LIMIT) then
		token:SetStatus(STATUS_PROC_COMPLETE,true)
	end
	return token
end

--Xyz Procedure, "minc-maxc" monsters fit "func"
function Dazz.AddXyzProcedureLevelFree(c,func,minc,maxc)
	local maxc=maxc or minc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(Dazz.XyzProcedureLevelFreeCondition(func,minc,maxc))
	e1:SetOperation(Dazz.XyzProcedureLevelFreeOperation(func,minc,maxc))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function Dazz.XyzProcedureLevelFreeFilter(c,xyzcard,func)
	return c:IsFaceup() and c:IsCanBeXyzMaterial(xyzcard) and (not func or func(c,xyzcard))
end
function Dazz.XyzProcedureLevelFreeCondition(func,minc,maxc)
	return function(e,c,og,min,max)
		if c==nil then return true end
		if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
		local tp=c:GetControler()
		local minc,maxc=minc,maxc
		if og then
			if min then
				if min>minc then minc=min end
				if max<maxc then maxc=max end
				if minc>maxc then return false end
				return og:IsExists(Dazz.XyzProcedureLevelFreeFilter,2,nil,c,func)
			else
				local count=og:GetCount()
				return count>=minc and count<=maxc
					and og:FilterCount(Dazz.XyzProcedureLevelFreeFilter,nil,c,func)==count
			end
		end
		return Duel.IsExistingMatchingCard(Dazz.XyzProcedureLevelFreeFilter,tp,LOCATION_MZONE,0,minc,nil,c,func)
	end
end
function Dazz.XyzProcedureLevelFreeOperation(func,minc,maxc)
	return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
		local mg=og or Duel.GetMatchingGroup(Dazz.XyzProcedureLevelFreeFilter,tp,LOCATION_MZONE,0,nil,c,func)
		if not og or min then
			local minc,maxc=minc,maxc
			if min then minc,maxc=math.max(minc,min),math.min(maxc,max) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			mg=mg:Select(tp,minc,maxc,nil)
		end
		local sg=Group.CreateGroup()
		local tc=mg:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg:Merge(sg1)
			tc=mg:GetNext()
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(mg)
		Duel.Overlay(c,mg)
	end
end

--Xyz Procedure, "minc1" level "lv" monsters fit "func" + "minc2-maxc2" level "lv" monsters
function Dazz.AddXyzProcedureDoubleStandarded(c,lv,func,minc1,minc2,maxc2)
	local maxc2=maxc2 or minc2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(Dazz.XyzProcedureDoubleStandardedCondition(func,lv,minc1,minc2,maxc2))
	e1:SetOperation(Dazz.XyzProcedureDoubleStandardedOperation(func,lv,minc1,minc2,maxc2))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function Dazz.XyzProcedureDoubleStandardedFilter1(c,xyzcard,lv)
	return c:IsFaceup() and c:IsCanBeXyzMaterial(xyzcard) and c:IsXyzLevel(xyzcard,lv)
end
function Dazz.XyzProcedureDoubleStandardedCondition(func,lv,minc1,minc2,maxc2)
	return function(e,c,og,min,max)
		if c==nil then return true end
		if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
		local tp=c:GetControler()
		local minc,maxc=minc1+minc2,minc1+maxc2
		local mg=nil
		if og then
			if min then
				if min>minc then minc=min end
				if max<maxc then maxc=max end
				if minc>maxc then return false end
			else
				local count=og:GetCount()
				return count>=minc and count<=maxc
					and og:FilterCount(Dazz.XyzProcedureDoubleStandardedFilter1,nil,c,lv)==count
					and og:IsExists(func,minc1,nil,c)
			end
			mg=og:Filter(Dazz.XyzProcedureDoubleStandardedFilter1,nil,c,lv)
		else
			mg=Duel.GetMatchingGroup(Dazz.XyzProcedureDoubleStandardedFilter1,c:GetControler(),LOCATION_MZONE,0,nil,c,lv)
		end
		return mg:GetCount()>=minc and mg:IsExists(func,minc1,nil,c)
	end
end
function Dazz.XyzProcedureDoubleStandardedOperation(func,lv,minc1,minc2,maxc2)
	return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
		local mg=og or Duel.GetMatchingGroup(Dazz.XyzProcedureDoubleStandardedFilter1,tp,LOCATION_MZONE,0,nil,c,lv)
		local minc,maxc=minc1+minc2,minc1+maxc2
		if not og or min then
			if min then mg=og:Filter(Dazz.XyzProcedureDoubleStandardedFilter1,nil,c,lv) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local mg1=mg:FilterSelect(tp,func,minc1,minc1,nil,c)
			mg:Sub(mg1)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			mg=mg:Select(tp,minc2,maxc2,nil)
			mg:Merge(mg1)
		end
		local sg=Group.CreateGroup()
		local tc=mg:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg:Merge(sg1)
			tc=mg:GetNext()
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(mg)
		Duel.Overlay(c,mg)
	end
end

--Common Effect Modules
function Dazz.VoidPendulumCommonEffect(c,sclchange)
	--PZone Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_PZONE)
	if sclchange then e1:SetLabel(1) end
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		if e:GetHandler():GetFlagEffect(9991000)==0 and eg:IsExists(function(c,tp)
			return Dazz.IsVoid(c,Card.GetPreviousCodeOnField) and c:IsPreviousPosition(POS_FACEUP)
				and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
			end,1,nil,tp) then
			e:GetHandler():RegisterFlagEffect(9991000,RESET_CHAIN,0,1)
			return true
		else
			return false
		end
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
			if e:GetLabel()==0 then
				local e1=Effect.CreateEffect(c)
				e1:SetDescription(aux.Stringid(9991000,0))
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
				e1:SetCountLimit(1)
				e1:SetValue(function(e,re,r,rp)
					return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
				end)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				c:RegisterEffect(e1)
			end
			Duel.SpecialSummonComplete()
		end
	end)
	c:RegisterEffect(e1)
	if not sclchange then return end
	--Scale Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	e2:SetTargetRange(LOCATION_SZONE,0)
	e2:SetTarget(function(e,rc)
		local c=e:GetHandler()
		local tc=Duel.GetFieldCard(c:GetControler(),LOCATION_SZONE,13-c:GetSequence())
		if tc and Dazz.IsVoid(tc) then return rc==tc else return false end
	end)
	e2:SetValue(sclchange)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CHANGE_LSCALE)
	c:RegisterEffect(e3)
end
function Dazz.VoidSynchroCommonEffect(c,code)
	--Synchro
	aux.AddSynchroProcedure2(c,nil,aux.FilterBoolFunction(Card.IsCode,code))
	c:EnableReviveLimit()
	--Lastwill
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetLabel(code)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp,chk)
		return e:GetHandler():IsPreviousPosition(POS_FACEUP)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Dazz.VoidSynchroSearchFilter,tp,0x51,0,1,nil,e:GetLabel()) end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,0x51)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,Dazz.VoidSynchroSearchFilter,tp,0x51,0,1,1,nil,e:GetLabel())
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end)
	c:RegisterEffect(e1)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	local m=_G["c"..c:GetOriginalCode()]
	if not m.material then
		m.material={code}
	end
end
function Dazz.VoidSynchroSearchFilter(c,code)
	return c:IsAbleToHand() and c:IsCode(code)
end
function Dazz.GodraMainCommonEffect(c,nolimit)
	--Procedure
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCondition(function(e,c)
		if c==nil then return true end
		return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(Dazz.GodraMainGraveCostFilter,c:GetControler(),LOCATION_HAND,0,1,c)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,c)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,Dazz.GodraMainGraveCostFilter,tp,LOCATION_HAND,0,1,1,c)
		Duel.SendtoGrave(g,REASON_COST)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	if nolimit then return end
	--Xyz Limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_DEFENSE)
	end)
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function Dazz.GodraMainGraveCostFilter(c)
	return c:IsRace(RACE_WYRM) and c:IsAbleToGraveAsCost()
end
function Dazz.GodraExtraCommonEffect(c,ddcode)
	if not c:IsStatus(STATUS_COPYING_EFFECT) then
		local lmcode=9991200
		if c:IsType(TYPE_SYNCHRO) then lmcode=lmcode+1 end
		if c:IsType(TYPE_XYZ) then lmcode=lmcode+2 end
		c:SetSPSummonOnce(lmcode)
	end
	if not ddcode then return end
	--DD Revive
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991211,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,ddcode)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local fil=function(c,e,tp) return Dazz.IsGodra(c) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) end
		if chk==0 then return eg:IsExists(function(c,tp) return c:IsFaceup() and c:IsRace(RACE_WYRM) and c:GetSummonPlayer()==tp end,1,e:GetHandler(),tp)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
		Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local fil=function(c,e,tp) return Dazz.IsGodra(c) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
			g:GetFirst():CompleteProcedure()
		end
	end)
	c:RegisterEffect(e1)
end
function Dazz.PneumaCommonEffect(c,code)
	--Cannot special summon
	local ex1=Effect.CreateEffect(c)
	ex1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ex1:SetType(EFFECT_TYPE_SINGLE)
	ex1:SetCode(EFFECT_SPSUMMON_CONDITION)
	ex1:SetValue(aux.FALSE)
	c:RegisterEffect(ex1)
	--Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e3)
	--Bonus Effect
	local m=_G["c"..code]
	m.Pneuma_Bonus_Effect(c)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetHintTiming(0,TIMING_DRAW_PHASE)
	e4:SetCountLimit(1,code)
	e4:SetLabel(code)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetTurnPlayer()~=tp
	end)
	e4:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
	end)
	e4:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Dazz.PneumaBonusTargetFilter,tp,LOCATION_MZONE,0,1,nil,e:GetLabel()) end
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Dazz.PneumaBonusTargetFilter,tp,LOCATION_MZONE,0,nil,e:GetLabel())
		if sg:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(e:GetLabel(),1))
		sg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		local tc=sg:GetFirst()
		if not tc:IsImmuneToEffect(e) then
			local m=_G["c"..e:GetLabel()]
			m.Pneuma_Bonus_Effect(e:GetHandler(),tc)
		end
	end)
	c:RegisterEffect(e4)
end
function Dazz.PneumaBonusTargetFilter(c,flag)
	return c:GetFlagEffect(flag)==0 and not c:IsCode(flag) and c:IsCode(9991301,9991302,9991303,9991304)
end
function Dazz.SliverCommonEffect(c,lv,code)
	--Bonus Effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c)
		return Dazz.IsSliver(c) and c:IsFaceup()
	end)
	e1:SetCode(code)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_REMOVE_TYPE)
	e3:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e3)
	--To Grave Search
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetLabel(lv)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if bit.band(c:GetPreviousLocation(),LOCATION_MZONE)==0 then return end
		local ex=Effect.CreateEffect(c)
		ex:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		ex:SetCode(EVENT_PHASE+PHASE_END)
		ex:SetRange(LOCATION_GRAVE)
		ex:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		ex:SetCountLimit(1)
		ex:SetLabel(e:GetLabel())
		ex:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
			if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
			Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
		end)
		ex:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
			if chk==0 then return Duel.IsExistingMatchingCard(Dazz.SliverSearchFilter,tp,LOCATION_DECK,0,1,nil,e:GetLabel()) end
			Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
		end)
		ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=Duel.SelectMatchingCard(tp,Dazz.SliverSearchFilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
			if g:GetCount()==0 then return end
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end)
		ex:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(ex)
	end)
	c:RegisterEffect(e4)
	--Global Bonus Effect
	if not Dazz.SliverKeyGroupSet then
		Dazz.SliverKeyGroupSet={}
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetCode(EVENT_ADJUST)
		ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			for code,keygroup in pairs(Dazz.SliverKeyGroupSet) do
				local m=_G["c"..code]
				local ug=Duel.GetMatchingGroup(function(c,g)
					return not g:IsContains(c) end,0,LOCATION_MZONE,LOCATION_MZONE,nil,keygroup)
				if ug:GetCount()~=0 then
					ug:ForEach(m.Sliver_General_Effect)
					keygroup:Merge(ug)
				end
			end
		end)
		Duel.RegisterEffect(ex,0)
	end
	if not Dazz.SliverKeyGroupSet[code] then
		Dazz.SliverKeyGroupSet[code]=Group.CreateGroup()
		Dazz.SliverKeyGroupSet[code]:KeepAlive()
	end
end
function Dazz.SliverSearchFilter(c,lv)
	return c:GetLevel()==lv and c:IsAbleToHand() and Dazz.IsSliver(c)
end
function Dazz.InheritorCommonEffect(c,val)
	--Last Will
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	ex:SetCode(EVENT_LEAVE_FIELD)
	ex:SetProperty(EFFECT_FLAG_DELAY)
	ex:SetLabel(val)
	ex:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		if chk==0 then return (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7))
			and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_SZONE)
			and c:GetPreviousSequence()>5 and c:IsLocation(LOCATION_EXTRA)
			and Duel.IsExistingMatchingCard(Dazz.InheritorToFieldFilter,tp,LOCATION_DECK,0,1,nil,e:GetLabel()) end
	end)
	ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,Dazz.InheritorToFieldFilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
		local tc=g:GetFirst()
		if tc then Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
	end)
	c:RegisterEffect(ex)
	if val==2 then return end
	--SP Procedure
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_FIELD)
	ex:SetCode(EFFECT_SPSUMMON_PROC)
	ex:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	ex:SetRange(LOCATION_HAND)
	ex:SetCondition(function(e,c)
		if c==nil then return true end
		local tp=c:GetControler()
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(Dazz.InheritorGraveCostFilter,tp,LOCATION_EXTRA,0,1,nil)
	end)
	ex:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,c)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,Dazz.InheritorGraveCostFilter,tp,LOCATION_EXTRA,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_COST)
	end)
	c:RegisterEffect(ex)
end
function Dazz.InheritorToFieldFilter(c,val)
	return c:IsType(TYPE_PENDULUM) and Dazz.IsInheritor(c,nil,val) and not c:IsForbidden()
end
function Dazz.InheritorGraveCostFilter(c)
	return c:IsType(TYPE_MONSTER) and Dazz.IsInheritor(c) and c:IsAbleToGraveAsCost()
end

--Simulated Setcodes
function Dazz.SimulatedSetCodeCore(c,f,v,func,...)
	local cf=f
	if type(cf)~="function" then cf=Card.GetCode end
	local t={cf(c)}
	for i,code in pairs(t) do
		for i,code2 in ipairs{...} do
			if code==code2 then return true end
		end
		local m=_G["c"..code]
		if m then
			local val=func(m)
			if val and (type(v)~=type(val) or val==v) then return true end
		end
	end
	return false
end
function Dazz.IsVoid(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_void end)
end
function Dazz.IsGodra(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_godra end)
end
function Dazz.IsSliver(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_sliver end,9991800)
end
function Dazz.IsInheritor(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_inheritor end)
end
function Dazz.IsAzorius(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_Azorius end)
end

--Modules for Eldrazi
--Eldrazi Scion
function Dazz.IsCanCreateEldraziScion(tp)
	return Duel.IsPlayerCanSpecialSummonMonster(tp,9991101,0,0x5011,500,500,1,RACE_REPTILE,ATTRIBUTE_LIGHT)
end
function Dazz.CreateEldraziScion(e,tp)
	local rand=math.random(6)
	local token=Duel.CreateToken(tp,9991100+rand)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_NONTUNER)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetValue(function(e,c)
		if not c then return false end
		return not c:IsRace(RACE_REPTILE)
	end)
	token:RegisterEffect(e2,true)
	return token
end
--Eldrazi Value means how much level can you reduce when synchro summon an eldrazi monster
function Dazz.EldraziValue(c,p)
	local v1=Duel.GetMatchingGroupCount(Dazz.EldraziValueFilter,p,LOCATION_MZONE,0,nil,9991115)
	local v2=Duel.GetMatchingGroupCount(Dazz.EldraziValueFilter,p,LOCATION_MZONE,0,nil,9991137)*2
	return v1+v2
end
function Dazz.EldraziValueFilter(c,code)
	return c:IsFaceup() and c:IsHasEffect(code)
end
--Custom synchro procedure for Eldrazi
function Dazz.AddSynchroProcedureEldrazi(c,ct,exi,spo)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(Dazz.SynConditionEldrazi(ct,99,exi))
	e1:SetTarget(Dazz.SynTargetEldrazi(ct,99))
	e1:SetOperation(Dazz.SynOperationEldrazi(ct,99,spo))
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
end
function Dazz.SynchroProcedureEldraziFilter1(c,syncard)
	return c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
		and c:IsCode(9991101,9991111,9991112,9991113)
end
function Dazz.SynchroProcedureEldraziFilter2(c,syncard)
	return c:IsNotTuner() and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
		and c:IsRace(RACE_REPTILE)
end
function Dazz.SynchroProcedureTunerFilter(c,syncard,lv,minc,maxc,g2)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local g2sub=g2:Clone()
	g2sub:RemoveCard(c)
	return g2sub:CheckWithSumEqual(Card.GetSynchroLevel,lv-tlv,minc,maxc,syncard)
end
function Dazz.SynConditionEldrazi(minc,maxc,exi)
	return function(e,c,tuner,mg)
		if c==nil then return true end
		if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
		local tp=c:GetControler()
		if exi and Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)<exi then return false end
		local lv=c:GetLevel()
		local g1,g2=nil,nil
		if mg then
			g1=mg:Filter(Dazz.SynchroProcedureEldraziFilter1,nil,c)
			g2=mg:Filter(Dazz.SynchroProcedureEldraziFilter2,nil,c)
		else
			g1=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
			g2=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		end
		local tuner=tuner
		if not tuner and pe then tuner=pe:GetOwner() end
		if tuner then
			return Dazz.SynchroProcedureEldraziFilter1(tuner,c)
				and Dazz.SynchroProcedureTunerFilter(tuner,c,lv,minc,maxc,g2)
		end
		local eldv=Dazz.EldraziValue(c,tp)
		for i=lv,2,-1 do
			if i+eldv<lv then break end
			if g1:IsExists(Dazz.SynchroProcedureTunerFilter,1,nil,c,i,minc,maxc,g2) then return true end
		end
		return false
	end
end
function Dazz.SynTargetEldrazi(minc,maxc)
	return function(e,tp,eg,ep,ev,re,r,rp,chk,c,tuner,mg)
		local g=Group.CreateGroup()
		local g1,g2=nil,nil
		if mg then
			g1=mg:Filter(Dazz.SynchroProcedureEldraziFilter1,nil,c)
			g2=mg:Filter(Dazz.SynchroProcedureEldraziFilter2,nil,c)
		else
			g1=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
			g2=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		end
		local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
		local lv,tlv=c:GetLevel(),0
		local eldv=Dazz.EldraziValue(c,tp)
		local selt={tp}
		local keyt={0}
		for i=lv,2,-1 do
			if i+eldv<lv then break end
			if g1:IsExists(Dazz.SynchroProcedureTunerFilter,1,nil,c,i,minc,maxc,g2) then
				table.insert(selt,aux.Stringid(9991100,i-2))
				table.insert(keyt,i)
			end
		end
		local mlv=nil
		if not selt[3] then
			mlv=keyt[2]
		else
			local sel=Duel.SelectOption(table.unpack(selt))
			mlv=keyt[sel+2]
		end
		if tuner then
			g:AddCard(tuner)
			tlv=tuner:GetSynchroLevel(c)
		else
			local sg1=nil
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			if pe then
				sg1=Group.FromCards(pe:GetOwner()):Select(tp,1,1,nil)
			else
				sg1=g1:FilterSelect(tp,Dazz.SynchroProcedureTunerFilter,1,1,nil,c,mlv,minc,maxc,g2)
			end
			g:Merge(sg1)
			tlv=sg1:GetFirst():GetSynchroLevel(c)
		end
		g2:Sub(g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local sg2=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,mlv-tlv,minc,maxc,c)
		g:Merge(sg2)
		if g then
			g:KeepAlive()
			e:SetLabelObject(g)
			return true
		else return false end
	end
end
function Dazz.SynOperationEldrazi(minc,maxc,spo)
	return function(e,tp,eg,ep,ev,re,r,rp,c,smat,mg)
		if spo then
			Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
		end
		local g=e:GetLabelObject()
		c:SetMaterial(g)
		Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
		g:DeleteGroup()
		if spo then
			spo(e,tp)
		end
	end
end
--Custom Xyz procedure for Eldrazi
function Dazz.AddXyzProcedureEldrazi(c,lv,minc,exi,spo)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(Dazz.XyzProcedureEldraziCondition(lv,minc,exi))
	e1:SetOperation(Dazz.XyzProcedureEldraziOperation(lv,minc,spo))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function Dazz.XyzProcedureEldraziFilter(c,xyzcard,lv)
	return c:IsFaceup() and c:IsCanBeXyzMaterial(xyzcard)
		and c:IsXyzLevel(xyzcard,lv) and c:IsRace(RACE_REPTILE)
end
function Dazz.XyzProcedureEldraziCondition(lv,minc,exi)
	return function(e,c,og,min,max)
		if c==nil then return true end
		if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
		local tp=c:GetControler()
		if exi and Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)<exi then return false end
		if og then
			if min then
				if min>minc or max<minc then return end
				return og:IsExists(Dazz.XyzProcedureEldraziFilter,2,nil,c,lv)
			else
				local count=og:GetCount()
				return count==minc
					and og:FilterCount(Dazz.XyzProcedureEldraziFilter,nil,c,lv)==count
			end
		end
		return Duel.IsExistingMatchingCard(Dazz.XyzProcedureEldraziFilter,tp,LOCATION_MZONE,0,minc,nil,c,lv)
	end
end
function Dazz.XyzProcedureEldraziOperation(lv,minc,spo)
	return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
		local mg=og or Duel.GetMatchingGroup(Dazz.XyzProcedureEldraziFilter,tp,LOCATION_MZONE,0,nil,c,lv)
		if not og or min then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			mg=mg:Select(tp,minc,minc,nil)
		end
		local sg=Group.CreateGroup()
		local tc=mg:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg:Merge(sg1)
			tc=mg:GetNext()
		end
		if spo then
			Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(mg)
		Duel.Overlay(c,mg)
		if spo then
			spo(e,tp)
		end
	end
end
--Synchro Summon without maximun level for "Endless One"
function Dazz.AddSynchroProcedureEndlessOne(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(Dazz.SynConditionEndlessOne(1,99))
	e1:SetTarget(Dazz.SynTargetEndlessOne(1,99))
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,c,smat,mg)
		local g=e:GetLabelObject()
		c:SetMaterial(g)
		Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
		g:DeleteGroup()
	end)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
end
function Dazz.SynchroProcedureEndlessOneTunerFilter(c,minc,g2)
	return g2:IsExists(aux.TRUE,minc,c)
end
function Dazz.SynConditionEndlessOne(minc,maxc)
	return function(e,c,tuner,mg)
		if c==nil then return true end
		if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
		local g1,g2=nil,nil
		if mg then
			g1=mg:Filter(Dazz.SynchroProcedureEldraziFilter1,nil,c,f1)
			g2=mg:Filter(Dazz.SynchroProcedureEldraziFilter2,nil,c,f2)
		else
			g1=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,f1)
			g2=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,f2)
		end
		local tuner=tuner
		if not tuner and pe then tuner=pe:GetOwner() end
		if tuner then
			return Dazz.SynchroProcedureEldraziFilter1(tuner,c,f1)
				and Dazz.SynchroProcedureEndlessOneTunerFilter(tuner,minc,g2)
		end
		return g1:IsExists(Dazz.SynchroProcedureEndlessOneTunerFilter,1,nil,minc,g2)
	end
end
function Dazz.SynTargetEndlessOne(minc,maxc)
	return function(e,tp,eg,ep,ev,re,r,rp,chk,c,tuner,mg)
		local g=Group.CreateGroup()
		local g1,g2=nil,nil
		if mg then
			g1=mg:Filter(Dazz.SynchroProcedureEldraziFilter1,nil,c,f1)
			g2=mg:Filter(Dazz.SynchroProcedureEldraziFilter2,nil,c,f2)
		else
			g1=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,f1)
			g2=Duel.GetMatchingGroup(Dazz.SynchroProcedureEldraziFilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,f2)
		end
		local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
		local mlv,tlv=e:GetLabel(),0
		if tuner then
			g:AddCard(tuner)
		else
			local sg1=nil
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			if pe then
				sg1=Group.FromCards(pe:GetOwner()):Select(tp,1,1,nil)
			else
				sg1=g1:FilterSelect(tp,Dazz.SynchroProcedureEndlessOneTunerFilter,1,1,nil,minc,g2)
			end
			g:Merge(sg1)
		end
		g2:Sub(g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local sg2=g2:Select(tp,minc,maxc,nil)
		g:Merge(sg2)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
end