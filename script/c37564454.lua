--百慕 冷淡的视线·萨拉  
require "/expansions/script/c37564765"
function c37564454.initial_effect(c)
	senya.bm(c)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564454,0))
	e3:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(senya.bmsscon)
	e3:SetTarget(c37564454.tg)
	e3:SetOperation(c37564454.op)
	c:RegisterEffect(e3)
end
function c37564454.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and e:GetHandler():IsAbleToDeck() end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c37564454.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>0 and e:GetHandler():IsRelateToEffect(e) then
		Duel.ShuffleDeck(tp)
		Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	end 
end
