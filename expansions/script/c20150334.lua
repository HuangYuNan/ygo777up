--精灵·八舞夕弦
function c20150334.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150334,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c20150334.eqcost)
	e1:SetTarget(c20150334.eqat)
	e1:SetOperation(c20150334.eqop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(20150334,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c20150334.target2)
	e2:SetOperation(c20150334.operation2)
	c:RegisterEffect(e2)
end
function c20150334.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,20150334)==0 end
	Duel.RegisterFlagEffect(tp,20150334,RESET_PHASE+PHASE_END,0,1)
end
function c20150334.eqat(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and at:IsControler(1-tp) and at:IsRelateToBattle() and at:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(at)
end
function c20150334.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
	else
		Duel.Equip(tp,c,tc,true)
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c20150334.eqlimit)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
				local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
		--cannot change position
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_EQUIP)
		e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c20150334.eqlimit(e,c)
	return e:GetOwner()==c
end
function c20150334.filter(c,e,tp)
	return c:IsFaceup() and c:IsCode(20150306) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20150334.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c20150334.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c20150334.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c20150334.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c20150334.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end