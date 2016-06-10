senya=senya or {}
os=require('os')
--7CG universal scripts
--test parts
if not Card.GetDefense then
	Card.GetDefense=Card.GetDefense
	Card.GetBaseDefense=Card.GetBaseDefense
	Card.GetBaseDefense=Card.GetBaseDefense
	Card.GetPreviousDefenseOnField=Card.GetPreviousDefenseOnField
	Card.IsDefensePos=Card.IsDefensePos
	Card.IsDefenseBelow=Card.IsDefenseBelow
	Card.IsDefenseAbove=Card.IsDefenseAbove
end
--xyz summon of prim
function senya.rxyz1(c,rk,f)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(senya.xyzcon1(rk,f))
	e1:SetOperation(senya.xyzop1(rk,f))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function senya.mfilter(c,xyzc,rk,f)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsCanBeXyzMaterial(xyzc) and (not rk or c:GetRank()==rk) and (not f or f(c))
end
function senya.xyzfilter1(c,g,ct)
	return g:IsExists(senya.xyzfilter2,ct,c,c:GetRank())
end
function senya.xyzfilter2(c,rk)
	return c:GetRank()==rk
end
function senya.xyzcon1(rk,f)
return function(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local minc=2
	local maxc=64
	if min then
		minc=math.max(minc,min)
		maxc=max
	end
	local ct=math.max(minc-1,-ft)
	local mg=nil
	if og then
		mg=og:Filter(senya.mfilter,nil,c,rk,f)
	else
		mg=Duel.GetMatchingGroup(senya.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
	end
	return maxc>=2 and mg:IsExists(senya.xyzfilter1,1,nil,mg,ct)
end
end
function senya.xyzop1(rk,f)
return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	if og and not min then
		g=og
	else
		local mg=nil
		if og then
			mg=og:Filter(senya.mfilter,nil,c,rk,f)
		else
			mg=Duel.GetMatchingGroup(senya.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
		end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local minc=2
		local maxc=64
		if min then
			minc=math.max(minc,min)
			maxc=max
		end
		local ct=math.max(minc-1,-ft)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,senya.xyzfilter1,1,1,nil,mg,ct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,senya.xyzfilter2,ct,maxc-1,g:GetFirst(),g:GetFirst():GetRank())
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
end

function senya.rxyz2(c,rk,f,ct)
	if not ct then ct=2 end
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(senya.xyzcon2(rk,f,ct))
	e1:SetOperation(senya.xyzop2(rk,f,ct))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
--reborn for mokou
function senya.xyzcon2(rk,f,ct)
return function(e,c,og)
	local lct=ct-1
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	if og then
		mg=og:Filter(senya.mfilter,nil,c,rk,f)
	else
		mg=Duel.GetMatchingGroup(senya.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
	end
	local lm=0-ct
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>lm
		and mg:IsExists(senya.xyzfilter1,lct,nil,mg,lct)
end
end
function senya.xyzop2(rk,f,ct)
return function(e,tp,eg,ep,ev,re,r,rp,c,og)
	local lct=ct-1
	local g=nil
	local sg=Group.CreateGroup()
	if og then
		g=og
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
	else
		local mg=Duel.GetMatchingGroup(senya.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,senya.xyzfilter1,1,1,nil,mg,lct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,senya.xyzfilter2,lct,lct,g:GetFirst(),g:GetFirst():GetRank())
		g:Merge(g2)
		local tc=g:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=g:GetNext()
		end
	end
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
end

--mokou reborn
function senya.mk(c,ct,cd,eff,con,exop,excon)
	if not cd then cd=c:GetCode() end
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(ct,cd)
	e2:SetCondition(senya.mkcon(eff,con))
	e2:SetTarget(senya.mktg)
	e2:SetOperation(senya.mkop(exop,excon))
	c:RegisterEffect(e2)
end
function senya.mkcon(eff,con)
	if eff then
		return function(e,tp,eg,ep,ev,re,r,rp)
			return bit.band(e:GetHandler():GetReason(),0x41)==0x41 and (not con or con(e,tp,eg,ep,ev,re,r,rp))
		end
	else
		return function(e,tp,eg,ep,ev,re,r,rp)
			return e:GetHandler():IsReason(REASON_DESTROY) and (not con or con(e,tp,eg,ep,ev,re,r,rp))
		end
	end
end
function senya.mktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function senya.mkop(exop,excon)
return function(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 and exop and (not excon or excon(e,tp,eg,ep,ev,re,r,rp)) then
		exop(e,tp,eg,ep,ev,re,r,rp)
	end
end
end
--chk if is 7cg
function senya.cgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(senya.cgfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
end
function senya.cgfilter(c)
	return senya.unifilter(c) and c:IsFaceup()
end
function senya.unifilter(c)
	return (c:IsSetCard(0x770) or c:IsSetCard(0x772) or c:IsSetCard(0x773) or c:IsSetCard(0x775) or c:IsSetCard(0x776)) and c:IsType(TYPE_MONSTER)
end
function senya.uniprfilter(c)
	return ((c:IsSetCard(0x770) and c:IsType(TYPE_XYZ)) or (c:IsSetCard(0x775) and c:IsType(TYPE_XYZ)) or (c:IsSetCard(0x776) and c:IsType(TYPE_XYZ)) or c:IsSetCard(0x772) or c:IsSetCard(0x773)) and c:IsType(TYPE_MONSTER)
end
--rm mat cost
function senya.rmovcost(ct)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
end

function senya.discost(ct)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,ct,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,ct,ct,REASON_COST+REASON_DISCARD)
end
end

---check date dt="Mon" "Tue" etc
function senya.weekcon(dt)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local st=os.date()
		local dt1=st:sub(1,3)
		return dt==dt1
	end
end
--copy effect c=getcard(nil=orcard) tc=sourcecard ht=showcard(bool) res=reset event(nil=no reset)
function senya.copy(e,c,tc,ht,res)
		if not c then c=e:GetHandler() end
		if not res then res=RESET_EVENT+0x1fe0000 end
		if tc and c:IsFaceup() and c:IsRelateToEffect(e) then
			local code=tc:GetOriginalCode()
			local atk=tc:GetBaseAttack()
			local def=tc:GetBaseDefense()
			local cid=0
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(res)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetValue(code)
			c:RegisterEffect(e1)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetReset(res)
			e3:SetCode(EFFECT_SET_BASE_ATTACK)
			e3:SetValue(atk)
			c:RegisterEffect(e3)
			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e4:SetReset(res)
			e4:SetCode(EFFECT_SET_BASE_DEFENSE)
			e4:SetValue(def)
			c:RegisterEffect(e4)
			if not tc:IsType(TYPE_TRAPMONSTER) then
				cid=c:CopyEffect(code,res)
			end
			if ht then
				Duel.Hint(HINT_CARD,0,code)
			end
		end
end
--universals for sww

--swwss(ct=discount ls=Lunatic Sprinter)
function senya.sww(c,ct,ctxm,ctsm,ls)
	if ctxm then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		e1:SetValue(1)
		c:RegisterEffect(e1)
	end
	if ctsm then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e3:SetValue(1)
		c:RegisterEffect(e3)
	end
	--ss
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(c:GetCode(),0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCost(senya.swwsscost(ct,ls))
	e4:SetTarget(senya.swwsstg)
	e4:SetOperation(senya.swwssop)
	c:RegisterEffect(e4)
end
function senya.swwsscost(ct,ls)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
			   if chk==0 then return Duel.IsExistingMatchingCard(senya.swwssfilter,tp,LOCATION_HAND,0,ct,e:GetHandler(),e,ls) end
			   Duel.DiscardHand(tp,senya.swwssfilter,ct,ct,REASON_COST,e:GetHandler(),e,ls)
		   end
end
function senya.swwsstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function senya.swwssop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function senya.swwssfilter(c,e,ls)
	return (c:IsSetCard(0x773) or (ls and c:GetTextAttack()==-2 and c:GetTextAttack()==-2)) and not c:IsCode(e:GetHandler():GetCode()) and c:IsAbleToGraveAsCost()
end
--for judge blank extra
function senya.swwblex(e,tp)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)==0
end
--for sww rm grave
function senya.swwcostfilter(c)
	return c:IsSetCard(0x773) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function senya.swwrmcost(ct)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
			   if chk==0 then return Duel.IsExistingMatchingCard(senya.swwcostfilter,tp,LOCATION_GRAVE,0,ct,nil) end
			   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			   local g=Duel.SelectMatchingCard(tp,senya.swwcostfilter,tp,LOCATION_GRAVE,0,ct,ct,nil)
			   Duel.Remove(g,POS_FACEUP,REASON_COST)
		   end
end

--universals for bm

--bmss ctg=category istg=is-target-effect

function senya.bm(c,tg,op,istg,ctg)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564765,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET) 
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCost(senya.bmssct(c:GetCode()))
	e4:SetTarget(senya.bmsstg)
	e4:SetOperation(senya.bmssop)
	c:RegisterEffect(e4)
	if op then
		local e1=Effect.CreateEffect(c)
		if ctg then e1:SetCategory(ctg) end
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)  
		if istg then
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
		else
			e1:SetProperty(EFFECT_FLAG_DELAY)
		end
		e1:SetCondition(senya.bmsscon)
		if tg then e1:SetTarget(tg) end
		e1:SetOperation(op)
		c:RegisterEffect(e1)
	end
end
function senya.bmssfilter(c)
   return c:IsAbleToHand() and senya.bmchkfilter(c) and c:IsFaceup()
end
function senya.bmssct(cd)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if not cd then return false end
	if chk==0 then return Duel.GetFlagEffect(tp,cd)==0 end
	Duel.RegisterFlagEffect(tp,cd,RESET_PHASE+PHASE_END,0,1)
end
end
function senya.bmsstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and senya.bmssfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingTarget(senya.bmssfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,senya.bmssfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function senya.bmssop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			if Duel.SpecialSummonStep(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP) then
				e:GetHandler():RegisterFlagEffect(37564499,RESET_EVENT+0x1fe0000,0,1)
				Duel.SpecialSummonComplete()
			end
		end
	end
end
function senya.bmsscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(37564499)>0
end
--check if is bm
function senya.bmchkfilter(c)
	return c:IsSetCard(0x775) and c:IsType(TYPE_MONSTER)
end
--damage chk for bm
--1=remove 2=extraattack 3=atk3000 4=draw
function senya.bmdamchkop(e,tp,eg,ep,ev,re,r,rp)
local ct=e:GetLabel()
local c=e:GetHandler()
local bc=c:GetBattleTarget()
if ct==0 then return end
if c:IsRelateToEffect(e) and c:IsFaceup() then
	Duel.ConfirmDecktop(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	local ag=g:Filter(senya.bmchkfilter,nil)
	if ag:GetCount()>0 then
		local val=0
		local tc=ag:GetFirst()
		while tc do
			val=val+tc:GetTextAttack()
			tc=ag:GetNext()
		end
		local t1=ag:FilterCount(Card.IsCode,nil,37564451)
		local t2=ag:FilterCount(Card.IsCode,nil,37564452)
		local t3=ag:FilterCount(Card.IsCode,nil,37564453)
		local t4=ag:FilterCount(Card.IsCode,nil,37564454)
		if t1>0 and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,bc) then
			Duel.Hint(HINT_CARD,0,37564451)
			if Duel.SelectYesNo(tp,aux.Stringid(37564765,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,t1,bc)
				if g:GetCount()>0 then
					Duel.HintSelection(g)
					Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
				end
			end
		end
		if t2>0 then
			Duel.Hint(HINT_CARD,0,37564452)
			for i=1,t2 do
			   c:RegisterFlagEffect(37564498,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			end
		end
		if t3>0 then
			Duel.Hint(HINT_CARD,0,37564453)
			val=val+(t3*1500)
		end
		if t4>0 then
			Duel.Hint(HINT_CARD,0,37564454)
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,t4*2,REASON_EFFECT)
		end
		if val>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
			e1:SetValue(val)
			c:RegisterEffect(e1)
		end  
		if Duel.SelectYesNo(tp,aux.Stringid(37564765,2)) then
			local thg=ag:Filter(senya.adfilter,nil)
			if thg:GetCount()>0 then
				local thc=thg:Select(tp,1,1,nil)
				Duel.SendtoHand(thc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,thc)
			end
		end
	end
	Duel.ShuffleDeck(tp)
end
end
function senya.adfilter(c)
	return c:IsAbleToHand() and c:IsLocation(LOCATION_DECK)
end
--bm attack oppolimit
function senya.bmdamchk(c,lm)
	if lm then
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(senya.bmaclimit)
	e2:SetCondition(senya.bmactcon)
	c:RegisterEffect(e2)
	end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(senya.bmexat)
	c:RegisterEffect(e4)
end
function senya.bmaclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function senya.bmactcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function senya.bmexat(e,c)
	return c:GetFlagEffect(37564498)
end
--for condition of damchk
function senya.bmdamchkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
--for cost of rmex
function senya.bmrmcostfilter(c)
	return senya.bmchkfilter(c) and c:IsAbleToRemoveAsCost()
end
function senya.bmrmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(senya.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,senya.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)

end
--for release bm L5
--fr=must be ssed
function senya.bmrl(c,fr)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564765,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(senya.bmrlcon)
	e1:SetOperation(senya.bmrlop)
	c:RegisterEffect(e1)
	if fr then
		local e2=Effect.CreateEffect(c)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+  EFFECT_FLAG_UNCOPYABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SPSUMMON_CONDITION)
		c:RegisterEffect(e2)
	end
end
function senya.bmrlfilter(c)
	return senya.bmchkfilter(c) and c:IsFaceup()
end
function senya.bmrlcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,senya.bmrlfilter,1,nil)
end
function senya.bmrlop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local g=Duel.SelectReleaseGroup(tp,senya.bmrlfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end


--universals for paranoia
function senya.pr1(c,lv,atk,hl,max)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),lv,4,senya.provfilter(atk),aux.Stringid(37564765,3))
	c:EnableReviveLimit()
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(senya.primmcon)
	e5:SetValue(senya.primmfilter(atk,max))
	c:RegisterEffect(e5)
end
function senya.primmcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--changes
function senya.provfilter(atk)
	return function(c)
		return c:IsFaceup() and c:IsSetCard(0x776) and c:GetAttack()==0 and c:GetDefense()==atk
	end
end
function senya.primmfilter(atk,max,hl)
	if not hl then return aux.TRUE end
	return function(e,te)
		return (te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner() and ((te:GetHandler():GetAttack()<atk and hl==0) or (te:GetHandler():GetAttack()>atk and hl==1))) or (te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and max)
	end
end

function senya.pr2(c,des,tg,op,istg,ctg)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	if des then
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e3)
	end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_ATTACK)
	end)
	e4:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	e5:SetValue(0)
	c:RegisterEffect(e5)
	if op then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(c:GetCode(),0))
		if ctg then e1:SetCategory(CATEGORY_TOHAND) end
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
		if istg then
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
		else
			e1:SetProperty(EFFECT_FLAG_DELAY)
		end
		e1:SetCountLimit(1,c:GetCode())
		if tg then e1:SetTarget(tg) end
		e1:SetOperation(op)
		c:RegisterEffect(e1)
	end
end

