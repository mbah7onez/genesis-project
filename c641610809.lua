-- --幻獣魔王バフォメット
-- --Berfomet the Phantom Beast Dark Ruler
-- --scripted by pyrQ
-- local s,id=GetID()
-- function s.initial_effect(c)
-- 	c:EnableReviveLimit()
-- 	--Fusion Summon procedure
-- 	Fusion.AddProcMixN(c,true,true,s.ffilter,2)
-- 	--Its name is treated as "Chimera the Flying Mythical Beast"
-- 	local e1=Effect.CreateEffect(c)
-- 	e1:SetDescription(aux.Stringid(id,0))
-- 	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
-- 	e1:SetType(EFFECT_TYPE_IGNITION)
-- 	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
-- 	e1:SetRange(LOCATION_EXTRA)
-- 	e1:SetCountLimit(1,id)
-- 	e1:SetCondition(aux.NOT(s.spquickcon))
-- 	e1:SetTarget(s.sptg)
-- 	e1:SetOperation(s.spop)
-- 	c:RegisterEffect(e1)
-- 	--Send 1 Beast, Fiend, or Illusion monster from your Deck to the GY
-- 	local e2=e1:Clone()
-- 	e2:SetType(EFFECT_TYPE_QUICK_O)
-- 	e2:SetCode(EVENT_FREE_CHAIN)
-- 	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
-- 	e2:SetCondition(s.spquickcon)
-- 	c:RegisterEffect(e2)
-- 	--Special Summon 1 of your banished Beast, Fiend, or Illusion monsters
-- 	local e3=Effect.CreateEffect(c)
-- 	e3:SetDescription(aux.Stringid(id,1))
-- 	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
-- 	e3:SetType(EFFECT_TYPE_QUICK_O)
-- 	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
-- 	e3:SetCode(EVENT_FREE_CHAIN)
-- 	e3:SetRange(LOCATION_GRAVE)
-- 	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
-- 	e3:SetCountLimit(1,{id,1})
-- 	e3:SetCondition(function(e,tp) return Duel.IsTurnPlayer(1-tp) end)
-- 	e3:SetCost(aux.bfgcost)
-- 	e3:SetTarget(s.sptg)
-- 	e3:SetOperation(s.spop)
-- 	c:RegisterEffect(e3)
-- end
-- s.listed_names={CARD_CHIMERA_MYTHICAL_BEAST,id}
-- function s.ffilter(c,fc,sumtype,sp,sub,mg,sg)
-- 	return c:IsRace(RACE_BEAST|RACE_FIEND|RACE_ILLUSION,fc,sumtype,sp) and (not sg or sg:FilterCount(aux.TRUE,c)==0 or not sg:IsExists(Card.IsRace,1,c,c:GetRace(),fc,sumtype,sp))
-- end
-- s.listed_names={id}
-- function s.spfilter(c,tp)
-- 	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK) and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
-- 		and c:IsFaceup() and Duel.GetMZoneCount(tp,c)>0
-- end
-- function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
-- 	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and s.spfilter(chkc,tp) end
-- 	local c=e:GetHandler()
-- 	if chk==0 then return Duel.IsExistingTarget(s.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tp)
-- 		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
-- 	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
-- 	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,tp)
-- 	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,0)
-- 	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_HAND)
-- end
-- function s.spop(e,tp,eg,ep,ev,re,r,rp)
-- 	local c=e:GetHandler()
-- 	local tc=Duel.GetFirstTarget()
-- 	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_REMOVED) and c:IsRelateToEffect(e) then
-- 		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
-- 	end
-- end
-- function s.spquickcon(e,tp,eg,ep,ev,re,r,rp)
-- 	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
-- end
-- function s.tgfilter(c)
-- 	return c:IsRace(RACE_BEAST|RACE_FIEND|RACE_ILLUSION) and c:IsAbleToGrave()
-- end
-- function s.spfilter(c,e,tp)
-- 	return c:IsRace(RACE_BEAST|RACE_FIEND|RACE_ILLUSION) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
-- 		and not c:IsCode(id)
-- end
-- function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
-- 	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and s.spfilter(chkc,e,tp) end
-- 	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
-- 		and Duel.IsExistingTarget(s.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
-- 	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
-- 	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
-- 	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
-- end
-- function s.spop(e,tp,eg,ep,ev,re,r,rp)
-- 	local tc=Duel.GetFirstTarget()
-- 	if tc:IsRelateToEffect(e) then
-- 		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
-- 	end
-- end

--Genesis Methanosian
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Summon procedure
	Fusion.AddProcMixN(c,true,true,s.ffilter,2)
	--Special Summon itself from the hand (Ignition)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,id)
	e1:SetCondition(aux.NOT(s.spquickcon))
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--Special Summon itself from the hand (Quick if the opponent controls monsters)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	e2:SetCondition(s.spquickcon)
	c:RegisterEffect(e2)
end
s.listed_names={id}
function s.ffilter(c,fc,sumtype,sp,sub,mg,sg)
	return c:IsRace(RACE_DRAGON|RACE_PYRO|RACE_PLANT,fc,sumtype,sp) and (not sg or sg:FilterCount(aux.TRUE,c)==0 or not sg:IsExists(Card.IsRace,1,c,c:GetRace(),fc,sumtype,sp))
end
function s.spfilter(c,tp)
	return c:IsRace(RACE_DRAGON+RACE_PYRO+RACE_PLANT) and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
		and c:IsFaceup() and Duel.GetMZoneCount(tp,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and s.spfilter(chkc,tp) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(s.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_GRAVE,2,nil,tp)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_GRAVE,2,2,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_REMOVED) and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.spquickcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end