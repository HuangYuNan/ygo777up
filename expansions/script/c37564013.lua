--元素的使者·Prim
require "script/c37564765"
function c37564013.initial_effect(c)
	senya.rxyz1(c,4)
	--攻击上升
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c37564013.atkval)
	c:RegisterEffect(e2)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_UPDATE_DEFENSE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c37564013.atkval)
	c:RegisterEffect(e8)
	--3属性不会成为对象
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(aux.tgval)
	e3:SetCondition(c37564013.indcon)
	c:RegisterEffect(e3)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetCondition(c37564013.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--2属性吸素材
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(37564013,0))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLE_START)
	e5:SetCondition(c37564013.descon)
	e5:SetTarget(c37564013.destg)
	e5:SetOperation(c37564013.desop)
	c:RegisterEffect(e5)
	--4属性3康
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(37564013,1))
	e6:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_CHAINING)
	e6:SetCountLimit(1)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c37564013.discon)
	e6:SetTarget(c37564013.distg)
	e6:SetOperation(c37564013.disop)
	c:RegisterEffect(e6)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(37564013,13))
	e9:SetCategory(CATEGORY_REMOVE)
	e9:SetType(EFFECT_TYPE_QUICK_O)
	e9:SetCode(EVENT_FREE_CHAIN)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetCondition(c37564013.tdcon)
	e9:SetTarget(c37564013.tdtg)
	e9:SetOperation(c37564013.tdop)
	c:RegisterEffect(e9)
	--6属性变身
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(37564013,2))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c37564013.sppcon)
	e7:SetCost(c37564013.sppcost)
	e7:SetTarget(c37564013.spptg)
	e7:SetOperation(c37564013.sppop)
	c:RegisterEffect(e7)
end
function c37564013.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c37564013.indcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():GetClassCount(Card.GetAttribute)>=3
end
function c37564013.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return e:GetHandler():GetOverlayGroup():GetClassCount(Card.GetAttribute)>=2 and bc and bit.band(bc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and not bc:IsType(TYPE_TOKEN)
end
function c37564013.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c37564013.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToBattle() and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c37564013.discon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():GetClassCount(Card.GetAttribute)>=4
	and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c37564013.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37564013.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c37564013.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():GetClassCount(Card.GetAttribute)>=5
end
function c37564013.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c37564013.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
		Duel.Remove(sg,POS_FACEUP,REASON_RULE)
end
function c37564013.sppcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():GetClassCount(Card.GetAttribute)>=6
end
function c37564013.sppcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:GetFlagEffect(37564013)==0 end
	local g=e:GetHandler():GetOverlayGroup()
	Duel.SendtoGrave(g,REASON_COST)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	c:RegisterFlagEffect(37564013,RESET_CHAIN,0,1)
end
function c37564013.fffilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and not c:IsCode(37564013) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c37564013.spptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c37564013.fffilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564013.sppop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564013.fffilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		for i=3,7 do
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564013,i))
		end
		Duel.Hint(HINT_CARD,0,37564013)
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564013,8))
		Duel.Hint(HINT_CARD,0,18326736)
		Duel.Hint(HINT_CARD,0,45950291)
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
		if sc:GetOriginalCode()==37564301 then
			for j=9,12 do
				Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(37564013,j))
			end
		end
	end
end

