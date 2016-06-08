--战舰ル级
function c233586.initial_effect(c)
    --synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,0x20),1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233586,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c233586.sumcon)
	e1:SetTarget(c233586.sumtg)
	e1:SetOperation(c233586.sumop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DRAW)
    e2:SetCategory(CATEGORY_DRAW)
	e2:SetRange(0x10)
	e2:SetCost(c233586.drcost)
	e2:SetCondition(c233586.drcon)
	e2:SetTarget(c233586.drtg)
	e2:SetOperation(c233586.drop)
    c:RegisterEffect(e2)
end
function c233586.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end	
function c233586.filter(c,e,tp)
	return c:IsRace(0x20) and c:IsAttribute(0x2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c233586.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,0x4)>0
		and Duel.IsExistingMatchingCard(c233586.filter,tp,0x20,0,1,nil,e,tp) end
	local ft=Duel.GetLocationCount(tp,0x4)
	local g=Duel.SelectTarget(tp,c233586.filter,tp,0x20,0,ft,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c233586.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e) 
	if g:GetCount()>0 then
    Duel.SpecialSummon(g,0,tp,tp,false,false,0x5) 
	end
end
function c233586.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),0x5,0x80)
end
function c233586.drcon(e,tp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and Duel.GetTurnPlayer()~=tp 
end
function c233586.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c233586.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end