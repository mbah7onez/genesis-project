--Genesis Galvanic Mechamorph
local s,id=GetID()
function s.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetTarget(s.eqtg)
	e1:SetOperation(s.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	--lvup
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(id,0))
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(s.lvcost)
	e5:SetTarget(s.chtg)
	e5:SetOperation(s.chop)
	c:RegisterEffect(e5)
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(s.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function s.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function s.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
-- function s.lvfilter(c)
-- 	return c:IsFaceup() and c:GetLevel()~=0
-- end
-- function s.chtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
-- 	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.lvfilter(chkc) end
-- 	if chk==0 then return Duel.IsExistingTarget(s.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	-- local lv=e:GetHandler():GetLevel()
	-- Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,1))
	-- e:SetLabel(Duel.AnnounceLevel(tp,1,12,lv))
	-- Duel.SelectTarget(tp,s.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
-- end
-- function s.chop(e,tp,eg,ep,ev,re,r,rp)
-- 	local tc=Duel.GetFirstTarget()
-- 	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
-- 		local e1=Effect.CreateEffect(e:GetHandler())
-- 		e1:SetType(EFFECT_TYPE_SINGLE)
-- 		e1:SetCode(EFFECT_CHANGE_LEVEL)
-- 		e1:SetValue(e:GetLabel())
-- 		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
-- 		tc:RegisterEffect(e1)
-- 	end
-- end
function s.chfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function s.chtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(s.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if chk==0 then return #g>0 end
	if Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2),aux.Stringid(id,3))==0 then
		local rc=Duel.AnnounceAnotherRace(g,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg=g:FilterSelect(tp,Card.IsDifferentRace,1,1,nil,rc)
		Duel.SetTargetCard(sg)
		e:SetLabel(0,rc)
	else
		local att=Duel.AnnounceAnotherAttribute(g,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg=g:FilterSelect(tp,Card.IsAttributeExcept,1,1,nil,att)
		Duel.SetTargetCard(sg)
		e:SetLabel(1,att)
	-- elseif
	-- 	local lv=Duel.AnnounceLevel(tp,1,8,g:GetFirst():GetLevel())
	-- 	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LVRANK)
	-- 	local g=Duel.SelectTarget(tp,s.chfilter,tp,LOCATION_MZONE,0,1,1,nil)
	-- 	Duel.SetTargetParam(lv)
	-- 	e:SetLabel(2,lv)
	end
end
function s.chop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local op,decl=e:GetLabel()
	if op==0 and tc:IsDifferentRace(decl) then
		-- Change monster type
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(decl)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
		tc:RegisterEffect(e1)
	elseif op==1 and tc:IsAttributeExcept(decl) then
		-- Change attribute
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(decl)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
		tc:RegisterEffect(e1)
	-- elseif op==2 then
	-- 	--change lv
	-- 	local e1=Effect.CreateEffect(e:GetHandler())
    --     e1:SetType(EFFECT_TYPE_SINGLE)
    --     e1:SetCode(EFFECT_CHANGE_LEVEL)
    --     e1:SetValue(lv)
    --     e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
    --     tc:RegisterEffect(e1)
	end
end