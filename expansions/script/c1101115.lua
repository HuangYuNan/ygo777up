--�ػ�Ů��  ����
function c1101115.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1101115,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1101115.eqcon)
	e1:SetTarget(c1101115.eqtg)
	e1:SetOperation(c1101115.eqop)
	c:RegisterEffect(e1)
	--Normal monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetCondition(c1101115.eqcon1)
	e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
	c:RegisterEffect(e1)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetCondition(c1101115.eqcon2)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(1101115,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCondition(c1101115.descon)
	e4:SetTarget(c1101115.destg)
	e4:SetOperation(c1101115.desop)
	c:RegisterEffect(e4)
end
function c1101115.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():CheckUniqueOnField(tp)
end
function c1101115.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1241)
end
function c1101115.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c1101115.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c1101115.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c1101115.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c1101115.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c1101115.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(800)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c1101115.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c1101115.eqcon1(e)
	return not e:GetHandler():GetEquipGroup():IsExists(Card.IsSetCard,1,nil,0x6241)
end
function c1101115.eqcon2(e)
	return e:GetHandler():GetEquipGroup():IsExists(Card.IsSetCard,1,nil,0x6241)
end
function c1101115.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bit.band(bc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c1101115.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c1101115.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end