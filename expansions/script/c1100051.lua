--风神之神德  神奈子
function c1100051.initial_effect(c)
	--spsummon1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100051,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1100051.spcon1)
	e1:SetTarget(c1100051.sptg)
	e1:SetOperation(c1100051.spop)
	c:RegisterEffect(e1)
	--spsummon2
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100051,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1100051.spcon2)
	e1:SetTarget(c1100051.sptg)
	e1:SetOperation(c1100051.spop)
	c:RegisterEffect(e1)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100051,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1100051)
	e1:SetTarget(c1100051.target)
	e1:SetOperation(c1100051.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3) 
end
function c1100051.spcon1(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x5240)
end
function c1100051.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function c1100051.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP_ATTACK)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) end
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c1100051.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)>0 then
		local g=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
function c1100051.filter(c,e,tp,m1,m2)
	if not c:IsSetCard(0x5240) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m1:Filter(Card.IsCanBeRitualMaterial,c,c)
	mg:Merge(m2)
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c1100051.mfilter(c)
	return c:IsSetCard(0x5240) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and not c:IsType(TYPE_XYZ) 
end
function c1100051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetRitualMaterial(tp)
		local mg2=Duel.GetMatchingGroup(c1100051.mfilter,tp,LOCATION_GRAVE,0,nil)
		return Duel.IsExistingMatchingCard(c1100051.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,mg1,mg2)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c1100051.operation(e,tp,eg,ep,ev,re,r,rp)
	local mg1=Duel.GetRitualMaterial(tp)
	local mg2=Duel.GetMatchingGroup(c1100051.mfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c1100051.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,mg1,mg2)
	local tc=tg:GetFirst()
	if tc then
		local mg=mg1:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		mg:Merge(mg2)
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,nil)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,1,tc)
		tc:SetMaterial(mat)
		local mg2=mat:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
		Duel.SendtoDeck(mg2,nil,2,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
		Duel.BreakEffect()
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(1100051,2))
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end