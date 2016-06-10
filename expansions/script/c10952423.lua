--罗星姬 双子座
function c10952423.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10952423.spcon)
	e0:SetOperation(c10952423.spop2)
	c:RegisterEffect(e0)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,10952423)
	e1:SetTarget(c10952423.eqtg)
	e1:SetOperation(c10952423.eqop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10952423,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e2:SetCountLimit(1,10952423)
	e2:SetCondition(c10952423.tdcon)
	e2:SetTarget(c10952423.tdtg)
	e2:SetOperation(c10952423.tdop)
	c:RegisterEffect(e2)
	--ret&draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10952423,1))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c10952423.target1)
	e3:SetOperation(c10952423.operation1)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e4)
end
function c10952423.spfilter(c)
	return c:IsSetCard(0x233) and c:IsType(TYPE_FUSION) and c:IsAbleToRemoveAsCost()
end
function c10952423.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x232)
end
function c10952423.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(c10952423.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return Duel.IsExistingMatchingCard(c10952423.spfilter,c:GetControler(),LOCATION_GRAVE,0,5,nil) 
end
end
function c10952423.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10952423.spfilter,tp,LOCATION_GRAVE,0,5,5,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST) 
end
function c10952423.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_FAIRY)
end
function c10952423.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c10952423.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c10952423.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c10952423.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10952423.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c10952423.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c10952423.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:GetPreviousControler()==tp
end
function c10952423.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10952423.cfilter,1,nil,tp)
end
function c10952423.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c10952423.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
			or Duel.SelectOption(tp,aux.Stringid(10952423,2),aux.Stringid(10952423,3))==0 then
			Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
		else
			Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
		end
	end
end
function c10952423.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c10952423.tgfilter(c,e)
	return not c:IsRelateToEffect(e)
end
function c10952423.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10952423.filter1(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingTarget(c10952423.filter1,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c10952423.filter1,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10952423.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if tg:IsExists(c10952423.tgfilter,1,nil,e) then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c10952423.eqlimit(e,c)
	return c==e:GetLabelObject()
end