--神之曲 假寐大师珂里朵拉
function c75000067.initial_effect(c)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),aux.NonTuner(Card.IsSetCard,0x52f),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1)
	e1:SetCondition(c75000067.drcon)
	e1:SetTarget(c75000067.drtg)
	e1:SetOperation(c75000067.drop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c75000067.spcon1)
	e2:SetTarget(c75000067.sptg)
	e2:SetOperation(c75000067.spop)
	c:RegisterEffect(e2)
end
function c75000067.drcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	return re:GetHandler():IsSetCard(0x52f) and not re:GetHandler():IsType(TYPE_PENDULUM)
end
function c75000067.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c75000067.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c75000067.tfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSetCard(0x52f) and c:IsAbleToRemove()
end
function c75000067.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c75000067.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000067.tfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,0)
end
function c75000067.filter3(c,e,tp,m)
	return c:IsSetCard(0x52f) and c:IsLevelBelow(m) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c75000067.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75000067.tfilter,tp,LOCATION_GRAVE,0,nil)
	e:SetLabel(Duel.GetMatchingGroupCount(c75000067.tfilter,tp,LOCATION_GRAVE,0,nil)*2)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		if Duel.IsExistingMatchingCard(c75000067.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetLabel()) then
			if Duel.SelectYesNo(tp,aux.Stringid(75000067,0)) then
				local g=Duel.SelectTarget(tp,c75000067.filter3,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel())
				Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
			end
		end 
	end
end