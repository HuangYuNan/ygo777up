--軍隊竜
function c20150302.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20150302,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c20150302.condition)
	e1:SetTarget(c20150302.destg)
	e1:SetOperation(c20150302.desop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_SZONE,0)
	e2:SetTarget(c20150302.indes)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c20150302.indes(e,c)
	return c:IsFaceup() and c:IsCode(20150324)
end
function c20150302.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c20150302.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c20150302.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150302.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20150302.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20150302.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end