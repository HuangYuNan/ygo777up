--驱魔师 拉比
function c3205005.initial_effect(c)
    --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3205005,0))
	e1:SetCountLimit(1,3205005)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c3205005.spcon)
	c:RegisterEffect(e1)
	--damage
    local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3205005,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,3205006)
	e2:SetTarget(c3205005.target)
	e2:SetOperation(c3205005.operation)
	c:RegisterEffect(e2)
	end
function c3205005.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x340) and not c:IsCode(3205005)
end
function c3205005.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c3205005.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c3205005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c3205005.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end