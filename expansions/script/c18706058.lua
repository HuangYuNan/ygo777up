--灼烂歼鬼 五河琴里
function c18706058.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xabb),1)
	c:EnableReviveLimit()
	--Attribute Dark
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(ATTRIBUTE_FIRE)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(85103922,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetTarget(c18706058.destg)
	e3:SetOperation(c18706058.desop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(80532587,1))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetTarget(c18706058.target)
	e4:SetOperation(c18706058.activate)
	c:RegisterEffect(e4)
end
function c18706058.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c18706058.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18706058.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c18706058.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c18706058.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c18706058.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
			Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
function c18706058.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c18706058.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c18706058.filter1,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,c) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,PLAYER_ALL,LOCATION_GRAVE)
end
function c18706058.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,95472621)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,c,TYPE_MONSTER)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
