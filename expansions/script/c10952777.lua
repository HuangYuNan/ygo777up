--超越的元素·Miracle·Evolution
function c10952777.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10952777,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c10952777.xyzcon)
	e1:SetOperation(c10952777.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--xyz summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10952777,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c10952777.xyzcon2)
	e2:SetOperation(c10952777.xyzop2)
	e2:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c10952777.aclimit)
	c:RegisterEffect(e3)
	--cannot remove
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_REMOVE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,1)
	e4:SetTarget(c10952777.rmlimit)
	c:RegisterEffect(e4)
	--attach
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTORY)
	e5:SetDescription(aux.Stringid(10952777,2))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCountLimit(1,10952777)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c10952777.condition)
	e5:SetTarget(c10952777.target)
	e5:SetOperation(c10952777.operation)
	c:RegisterEffect(e5)
	--atkup
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c10952777.value)
	c:RegisterEffect(e6)
end
c10952777.xyz_count=4
function c10952777.ovfilter(c,tp,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x239) and c:IsCanBeXyzMaterial(xyzc)
		and c:CheckRemoveOverlayCard(tp,2,REASON_COST)
end
function c10952777.ovfilter2(c)
	return c:IsFaceup() and c:GetLevel()==5 and c:IsRace(RACE_FAIRY) 
end
function c10952777.ovfilter3(c,tp,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x770) and c:IsCanBeXyzMaterial(xyzc)
		and c:CheckRemoveOverlayCard(tp,3,REASON_COST)
end
function c10952777.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft
	if 2<=ct then return false end
	if ct<1 and not og and Duel.IsExistingMatchingCard(c10952777.ovfilter,tp,LOCATION_MZONE,0,1,nil,tp,c) then
		return true
	end
	return Duel.CheckXyzMaterial(c,c10952777.ovfilter2,5,4,4,og)
end
function c10952777.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	if og then
		c:SetMaterial(og)
		Duel.Overlay(c,og)
	else
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local ct=-ft
		local b1=Duel.CheckXyzMaterial(c,c10952777.ovfilter2,5,4,4,og)
		local b2=ct<1 and Duel.IsExistingMatchingCard(c10952777.ovfilter,tp,LOCATION_MZONE,0,1,nil,tp,c)
		if b2 and (not b1 or Duel.SelectYesNo(tp,aux.Stringid(10952777,0))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local mg=Duel.SelectMatchingCard(tp,c10952777.ovfilter,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
			mg:GetFirst():RemoveOverlayCard(tp,2,2,REASON_COST)
			local mg2=mg:GetFirst():GetOverlayGroup()
			if mg2:GetCount()~=0 then
				Duel.Overlay(c,mg2)
			end
			c:SetMaterial(mg)
			Duel.Overlay(c,mg)
		else
			local mg=Duel.SelectXyzMaterial(tp,c,c10952777.ovfilter2,5,4,4)
			c:SetMaterial(mg)
			Duel.Overlay(c,mg)
		end
	end
end
function c10952777.xyzcon2(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft
	if 2<=ct then return false end
	if ct<1 and not og and Duel.IsExistingMatchingCard(c10952777.ovfilter3,tp,LOCATION_MZONE,0,1,nil,tp,c) then
		return true
	end
	return Duel.CheckXyzMaterial(c,c10952777.ovfilter2,5,4,4,og)
end
function c10952777.xyzop2(e,tp,eg,ep,ev,re,r,rp,c,og)
	if og then
		c:SetMaterial(og)
		Duel.Overlay(c,og)
	else
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local ct=-ft
		local b1=Duel.CheckXyzMaterial(c,c10952777.ovfilter2,5,4,4,og)
		local b2=ct<1 and Duel.IsExistingMatchingCard(c10952777.ovfilter3,tp,LOCATION_MZONE,0,1,nil,tp,c)
		if b2 and (not b1 or Duel.SelectYesNo(tp,aux.Stringid(10952777,1))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local mg=Duel.SelectMatchingCard(tp,c10952777.ovfilter3,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
			mg:GetFirst():RemoveOverlayCard(tp,3,3,REASON_COST)
			local mg2=mg:GetFirst():GetOverlayGroup()
			if mg2:GetCount()~=0 then
				Duel.Overlay(c,mg2)
			end
			c:SetMaterial(mg)
			Duel.Overlay(c,mg)
		else
			local mg=Duel.SelectXyzMaterial(tp,c,c10952777.ovfilter2,5,4,4)
			c:SetMaterial(mg)
			Duel.Overlay(c,mg)
		end
	end
end
function c10952777.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return loc==LOCATION_REMOVED and not re:GetHandler():IsImmuneToEffect(e)
end
function c10952777.rmlimit(e,c,p)
	return c:IsLocation(LOCATION_GRAVE)
end
function c10952777.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsType(TYPE_XYZ) and e:GetHandler():GetOverlayCount()>0
end
function c10952777.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
end
function c10952777.filter(c)
	return c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c10952777.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
	local og=c:GetOverlayGroup()
	if og:GetCount()==0 then return end
	Duel.SendtoGrave(og,REASON_EFFECT)
	Duel.Overlay(c,Group.FromCards(tc))
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		if g:IsExists(c10952777.filter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(10952777,3)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,c10952777.filter,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
			g:Sub(sg)
		end
		Duel.Destroy(g,REASON_EFFECT+REASON_REVEAL)
	end
end
end
function c10952777.atkfilter(c)
	return c:IsType(TYPE_XYZ)
end
function c10952777.value(e,c)
	return Duel.GetMatchingGroupCount(c10952777.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*300
end