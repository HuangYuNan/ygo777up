--天赋之凡才 学徒型格尼妲
function c60150711.initial_effect(c)
	c:SetUniqueOnField(1,0,60150711)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60150703,60150708,false,false)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	e11:SetValue(c60150711.splimit)
	c:RegisterEffect(e11)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(60150711,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c60150711.condition)
	e1:SetTarget(c60150711.target)
	e1:SetOperation(c60150711.operation)
	c:RegisterEffect(e1)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c60150711.spcon)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	--cannot target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetCondition(c60150711.spcon2)
	e4:SetValue(c60150711.tgvalue)
	c:RegisterEffect(e4)
end
function c60150711.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c60150711.filter(c)
	return c:IsFaceup()
end
function c60150711.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c60150711.filter,tp,0,LOCATION_MZONE,nil)
	local atk=g:GetSum(Card.GetDefense)
	local g2=Duel.GetMatchingGroup(c60150711.filter,tp,LOCATION_MZONE,0,nil)
	local atk2=g2:GetSum(Card.GetAttack)
	return atk>atk2
end
function c60150711.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_MZONE)
end
function c60150711.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c60150711.filter,tp,0,LOCATION_MZONE,nil)
	local atk=g:GetSum(Card.GetDefense)
	local g2=Duel.GetMatchingGroup(c60150711.filter,tp,LOCATION_MZONE,0,nil)
	local atk2=g2:GetSum(Card.GetAttack)
	local sg=Group.CreateGroup()
	while atk>atk2 and g:GetCount()>0 do
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local tc=g:Select(1-tp,1,1,nil):GetFirst()
		sg:AddCard(tc)
		g:RemoveCard(tc)
		atk=atk-tc:GetDefense()
	end
	Duel.SendtoDeck(sg,nil,2,REASON_RULE)
end
function c60150711.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
end
function c60150711.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c60150711.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
end