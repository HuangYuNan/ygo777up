--Sawawa-Fire in the Phoenix
require "/expansions/script/c37564765"
function c37564201.initial_effect(c)
senya.sww(c,2,true,false,false)
local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564201,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,37560201)
	e1:SetTarget(c37564201.destg)
	e1:SetOperation(c37564201.desop)
	c:RegisterEffect(e1)
	senya.mk(c,2,37560211,false,senya.swwblex)
end
function c37564201.filter1(c)
	return c:IsSetCard(0x773) and c:IsFaceup() and c:IsDestructable()
end
function c37564201.filter2(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and c:IsDestructable()
end
function c37564201.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c37564201.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c37564201.filter2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c37564201.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c37564201.filter2,tp,0,LOCATION_MZONE,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c37564201.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
