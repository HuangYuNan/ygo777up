--ヴォイド・ハイパー マミ
require "expansions/script/c9990000"
function c9991008.initial_effect(c)
	Dazz.VoidSynchroCommonEffect(c,9991004)
	--Immunity
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(function(e,re,r,rp)
		return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
	end)
	c:RegisterEffect(e1)
	--Destroy & Position Change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_POSITION)
	e2:SetDescription(aux.Stringid(9991008,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c9991008.dpctg)
	e2:SetOperation(c9991008.dpcop)
	c:RegisterEffect(e2)
end
c9991008.Dazz_name_void=2
function c9991008.dpctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c9991008.dpcfilter(chkc) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c9991008.dpcfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local d1=Duel.SelectTarget(tp,c9991008.dpcfilter,tp,LOCATION_SZONE,0,1,1,nil)
	local d2=Duel.GetMatchingGroup(c9991008.desfilter,tp,0,LOCATION_ONFIELD,nil)
	local c1=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil)
	if d2:GetCount()~=0 then Duel.SetOperationInfo(0,CATEGORY_DESTROY,d1 and d2,d2:GetCount()+1,0,0) else Duel.SetOperationInfo(0,CATEGORY_DESTROY,d1,1,0,0) end
	if c1:GetCount()~=0 then Duel.SetOperationInfo(0,CATEGORY_POSITION,c1,c1:GetCount(),0,0) end
	if e:GetHandler():GetOriginalCode()~=9991008 then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
end
function c9991008.dpcfilter(c)
	return c:IsFaceup() and (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c9991008.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c9991008.dpcop(e,tp,eg,ep,ev,re,r,rp)
	local d1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e):GetFirst() if not d1 then return end
	local d2=Duel.GetMatchingGroup(c9991008.desfilter,tp,0,LOCATION_ONFIELD,nil)
	local c1=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil)
	if d2:GetCount()~=0 then d2:AddCard(d1) Duel.Destroy(d2,REASON_EFFECT) else Duel.Destroy(d1,REASON_EFFECT) end
	if c1:GetCount()~=0 then Duel.ChangePosition(c1,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true) end
end