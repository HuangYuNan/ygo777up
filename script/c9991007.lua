--ヴォイド・ハイパー キョウコ
require "expansions/script/c9990000"
function c9991007.initial_effect(c)
	Dazz.VoidSynchroCommonEffect(c,9991003)
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
    --Remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991007,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c9991007.mbtg)
	e2:SetOperation(c9991007.mbop)
	c:RegisterEffect(e2)
end
c9991007.Dazz_name_void=2
function c9991007.mbtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	if e:GetHandler():GetOriginalCode()~=9991007 then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
end
function c9991007.mbop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end