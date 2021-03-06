--神天竜－サイズミック
require "expansions/script/c9990000"
function c9991205.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--To Hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,19991205)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(c9991205.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_GRAVE)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(c9991205.thfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.SendtoHand(rg,tp,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(0xfe)
	e2:SetCountLimit(1,29991205)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(function(c,mc)
			local mg=c:GetMaterial()
			return mg and mg:IsContains(mc) and Dazz.IsGodra(c) and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		end,1,nil,e:GetHandler())
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Draw(p,d,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991205.Dazz_name_godra=true
function c9991205.thfilter(c)
	return c:IsSetCard(0x46) and c:IsAbleToHand() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end