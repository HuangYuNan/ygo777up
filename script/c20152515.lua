--爱上&被爱上2
function c20152515.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c20152515.target)
	e1:SetOperation(c20152515.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c20152515.eqlimit)
	c:RegisterEffect(e2)
				---
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
		--end battle phase
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20152515,0))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCountLimit(1,20152515)
	e5:SetCondition(c20152515.condition5)
	e5:SetCost(c20152515.cost)
	e5:SetOperation(c20152515.operation5)
	c:RegisterEffect(e5)
	--rmecial summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152515,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,20152515)
	e3:SetCondition(c20152515.rmcon)
	e3:SetTarget(c20152515.rmtg)
	e3:SetOperation(c20152515.rmop)
	c:RegisterEffect(e3)
		--
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_EQUIP)
	e7:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	local e6=e7:Clone()
e6:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e6)
end
function c20152515.eqlimit(e,c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152515.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152515.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152515.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152515.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c20152515.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c20152515.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c20152515.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetEquipTarget()
	local bc=c:GetBattleTarget()
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c20152515.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and bc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,bc,1,0,LOCATION_GRAVE)
end
function c20152515.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c20152515.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152515.condition5(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.IsExistingMatchingCard(c20152515.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c20152515.cffilter(c)
	return c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c20152515.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152515.cffilter,tp,LOCATION_HAND,0,1,nil) and e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.IsExistingMatchingCard(c20152515.cffilter,tp,LOCATION_HAND,0,1,nil)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c20152515.operation5(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
