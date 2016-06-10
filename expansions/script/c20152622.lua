--GGO•诗乃
function c20152622.initial_effect(c)
	c:SetUniqueOnField(1,1,20152622)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152622.ovfilter,aux.Stringid(20152622,7),3,nil)
	c:EnableReviveLimit()
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(20152622,0))
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c20152622.descost)
	e2:SetTarget(c20152622.destg)
	e2:SetOperation(c20152622.desop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetCondition(c20152622.condition2)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--battle target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c20152622.condition2)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--cannot be target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c20152622.condition2)
	e5:SetValue(c20152622.tgvalue)
	c:RegisterEffect(e5)
end
function c20152622.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end 
function c20152622.ovfilter(c)
	return c:IsCode(20152604) and c:IsFaceup()
end
function c20152622.cfilter7(c)
	return c:IsFaceup() and c:IsSetCard(0xa290) and c:IsType(TYPE_XYZ) and not c:IsCode(20152622) and not c:IsCode(20152632)
end
function c20152622.condition2(e,c,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandler():GetControler()
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152604) and Duel.IsExistingMatchingCard(c20152622.cfilter7,tp,LOCATION_MZONE,0,1,nil)
end
function c20152622.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)
		and e:GetHandler():GetAttackAnnouncedCount()==0  end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c20152622.filter(c)
	return c:IsFaceup() and c:IsDestructable()
	end
function c20152622.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20152622.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152622.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20152622.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local d=g:GetFirst()
	local atk=0
	if d:IsFaceup() then atk=GetTextAttack() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c20152622.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk=0
		if tc:IsFaceup() then atk=tc:GetTextAttack() end
		if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
