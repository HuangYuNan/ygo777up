--星の世界   星野梦美
function c1103907.initial_effect(c)
	--synchro summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c1103907.syncon)
	e1:SetOperation(c1103907.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1103907,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c1103907.con)
	e1:SetTarget(c1103907.tg)
	e1:SetOperation(c1103907.op)
	c:RegisterEffect(e1)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1103907,1))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c1103907.eqtg)
	e1:SetOperation(c1103907.eqop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c1103907.atkval)
	c:RegisterEffect(e2) 
end
function c1103907.matfilter1(c,syncard)
	return c:IsType(TYPE_TUNER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSynchroMaterial(syncard)
end
function c1103907.matfilter2(c,syncard)
	return c:IsNotTuner() and c:IsSetCard(0x1240) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSynchroMaterial(syncard)
end
function c1103907.synfilter1(c,syncard,lv,g1,g2,g3,g4)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f1=c.tuner_filter
	if c:IsHasEffect(EFFECT_HAND_SYNCHRO) then
		return g3:IsExists(c1103907.synfilter2,1,c,syncard,lv-tlv,g2,g4,f1,c)
	else
		return g1:IsExists(c1103907.synfilter2,1,c,syncard,lv-tlv,g2,g4,f1,c)
	end
end
function c1103907.synfilter2(c,syncard,lv,g2,g4,f1,tuner1)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f2=c.tuner_filter
	if f1 and not f1(c) then return false end
	if f2 and not f2(tuner1) then return false end
	if (tuner1:IsHasEffect(EFFECT_HAND_SYNCHRO) and not c:IsLocation(LOCATION_HAND)) or c:IsHasEffect(EFFECT_HAND_SYNCHRO) then
		return g4:IsExists(c1103907.synfilter3,1,nil,syncard,lv-tlv,f1,f2,g2)
	else
		return g2:CheckWithSumEqual(Card.GetSynchroLevel,lv-tlv,1,62,syncard)
	end
end
function c1103907.synfilter3(c,syncard,lv,f1,f2,g2)
	if not (not f1 or f1(c)) and not (not f2 or f2(c)) then return false end
	local mlv=c:GetSynchroLevel(syncard)
	local slv=lv-mlv
	if slv<0 then return false end
	if slv==0 then
		return true
	else
		return g2:CheckWithSumEqual(Card.GetSynchroLevel,slv,1,61,syncard)
	end
end
function c1103907.syncon(e,c,tuner,mg)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-2 then return false end
	local g1=nil
	local g2=nil
	local g3=nil
	local g4=nil
	if mg then
		g1=mg:Filter(c1103907.matfilter1,nil,c)
		g2=mg:Filter(c1103907.matfilter2,nil,c)
		g3=mg:Filter(c1103907.matfilter1,nil,c)
		g4=mg:Filter(c1103907.matfilter2,nil,c)
	else
		g1=Duel.GetMatchingGroup(c1103907.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c1103907.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c1103907.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
		g4=Duel.GetMatchingGroup(c1103907.matfilter2,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		local tlv=tuner:GetSynchroLevel(c)
		if lv-tlv<=0 then return false end
		local f1=tuner.tuner_filter
		if not pe then
			return g1:IsExists(c1103907.synfilter2,1,tuner,c,lv-tlv,g2,g4,f1,tuner)
		else
			return c1103907.synfilter2(pe:GetOwner(),c,lv-tlv,g2,nil,f1,tuner)
		end
	end
	if not pe then
		return g1:IsExists(c1103907.synfilter1,1,nil,c,lv,g1,g2,g3,g4)
	else
		return c1103907.synfilter1(pe:GetOwner(),c,lv,g1,g2,g3,g4)
	end
end
function c1103907.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner,mg)
	local g=Group.CreateGroup()
	local g1=nil
	local g2=nil
	local g3=nil
	local g4=nil
	if mg then
		g1=mg:Filter(c1103907.matfilter1,nil,c)
		g2=mg:Filter(c1103907.matfilter2,nil,c)
		g3=mg:Filter(c1103907.matfilter1,nil,c)
		g4=mg:Filter(c1103907.matfilter2,nil,c)
	else
		g1=Duel.GetMatchingGroup(c1103907.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c1103907.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c1103907.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
		g4=Duel.GetMatchingGroup(c1103907.matfilter2,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		g:AddCard(tuner)
		local lv1=tuner:GetSynchroLevel(c)
		local f1=tuner.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner2=nil
		if not pe then
			local t2=g1:FilterSelect(tp,c1103907.synfilter2,1,1,tuner,c,lv-lv1,g2,g4,f1,tuner)
			tuner2=t2:GetFirst()
		else
			tuner2=pe:GetOwner()
			Group.FromCards(tuner2):Select(tp,1,1,nil)
		end
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		local m3=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		if tuner2:IsHasEffect(EFFECT_HAND_SYNCHRO) then
			m3=g4:FilterSelect(tp,c1103907.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2,g2)
			local lv3=m3:GetFirst():GetSynchroLevel(c)
			if lv-lv1-lv2-lv3>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
				local m4=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1-lv2-lv3,1,61,c)
				g:Merge(m4)
			end
		else
			m3=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1-lv2,1,62,c)
		end
		g:Merge(m3)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner1=nil
		local hand=nil
		if not pe then
			local t1=g1:FilterSelect(tp,c1103907.synfilter1,1,1,nil,c,lv,g1,g2,g3,g4)
			tuner1=t1:GetFirst()
		else
			tuner1=pe:GetOwner()
			Group.FromCards(tuner1):Select(tp,1,1,nil)
		end
		g:AddCard(tuner1)
		local lv1=tuner1:GetSynchroLevel(c)
		local f1=tuner1.tuner_filter
		local tuner2=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		if tuner1:IsHasEffect(EFFECT_HAND_SYNCHRO) then
			local t2=g3:FilterSelect(tp,c1103907.synfilter2,1,1,tuner1,c,lv-lv1,g2,g4,f1,tuner1)
			tuner2=t2:GetFirst()
		else
			local t2=g1:FilterSelect(tp,c1103907.synfilter2,1,1,tuner1,c,lv-lv1,g2,g4,f1,tuner1)
			tuner2=t2:GetFirst()
		end
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		local m3=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		if (tuner1:IsHasEffect(EFFECT_HAND_SYNCHRO) and not tuner2:IsLocation(LOCATION_HAND))
			or tuner2:IsHasEffect(EFFECT_HAND_SYNCHRO) then
			m3=g4:FilterSelect(tp,c1103907.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2,g2)
			local lv3=m3:GetFirst():GetSynchroLevel(c)
			if lv-lv1-lv2-lv3>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
				local m4=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1-lv2-lv3,1,61,c)
				g:Merge(m4)
			end
		else
			m3=g2:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv-lv1-lv2,1,63,c)
		end
		g:Merge(m3)
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c1103907.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c1103907.filter(c)
	return c:IsSetCard(0x1240) and c:IsAbleToHand()
end
function c1103907.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1103907.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1103907.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c1103907.filter,tp,LOCATION_GRAVE,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c1103907.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c1103907.filter1(c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c1103907.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_EXTRA) and chkc:IsControler(tp) and c1103907.filter1(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c1103907.filter1,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c1103907.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c1103907.eqlimit)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(c1103907.repval)
		tc:RegisterEffect(e3)
	end
end
function c1103907.eqlimit(e,c)
	return e:GetOwner()==c
end