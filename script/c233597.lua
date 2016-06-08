--海之少女 初音未来
function c233597.initial_effect(c)
    --synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
    --destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c233597.descost)
	e1:SetTarget(c233597.destg)
	e1:SetOperation(c233597.desop)
	c:RegisterEffect(e1)
end	
function c233597.filter(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c233597.rfilter(c)
	return  c:IsType(0x1) and c:IsAbleToRemoveAsCost()
end
function c233597.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(c233597.rfilter,tp,0x10,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c233597.rfilter,tp,0x10,0,1,1,nil)
	Duel.Remove(g,0x5,0x80)
end
function c233597.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x8) and chkc:IsControler(1-tp) and c233597.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c233597.filter,tp,0,0x8,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c233597.filter,tp,0,0x8,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetChainLimit(c233597.limit(g:GetFirst()))
end
function c233597.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c233597.limit(c)
	return	function (e,lp,tp)
				return e:GetHandler()~=c
			end
end