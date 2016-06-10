--战场女武神 塞利
function c11113021.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c11113021.splimit)
	c:RegisterEffect(e2)
	--remove & draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113021,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,11113021)
	e3:SetCondition(c11113021.condition)
	e3:SetTarget(c11113021.target)
	e3:SetOperation(c11113021.operation)
	c:RegisterEffect(e3)
	--salvage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11113021,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_REMOVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,11113021)
	e4:SetTarget(c11113021.destg)
	e4:SetOperation(c11113021.desop)
	c:RegisterEffect(e4)
end
function c11113021.splimit(e,c)
	return not (c:IsSetCard(0x15c) or c:IsType(TYPE_SYNCHRO))
end
function c11113021.condition(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return pc and pc:IsSetCard(0x15c)
end
function c11113021.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c11113021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c11113021.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingTarget(c11113021.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11113021.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c11113021.operation(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(Group.FromCards(tc,e:GetHandler()),REASON_EFFECT)
	end
end
function c11113021.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c11113021.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113021.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11113021.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c11113021.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and tc:GetPreviousControler()==tp then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end