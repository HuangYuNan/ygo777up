--天翔的努力家 学徒型奥伊菲
function c60150710.initial_effect(c)
	c:SetUniqueOnField(1,0,60150710)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60150702,60150708,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c60150710.splimit)
	c:RegisterEffect(e1)
	--Position Change
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c60150710.condition)
	e4:SetTarget(c60150710.pctg)
	e4:SetOperation(c60150710.pcop)
	c:RegisterEffect(e4)
	--destroy
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(60150710,1))
    e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c60150710.condition2)
    e2:SetTarget(c60150710.destg)
    e2:SetOperation(c60150710.desop)
    c:RegisterEffect(e2)
end
function c60150710.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c60150710.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if Duel.GetTurnPlayer()==tp then
		return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
	else
		return ph==PHASE_BATTLE
	end
end
function c60150710.pctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TURE,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c60150710.pcop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil) local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or sg:GetCount()==0 then return end
	Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
end
function c60150710.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup()
end
function c60150710.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsFaceup() and tc:GetDefense()<=c:GetAttack() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c60150710.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() and tc:GetDefense()<=c:GetAttack() then
		local atk=tc:GetDefense()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end