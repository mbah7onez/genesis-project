-- --Genesis Methanosian
local s,id=GetID()
function s.initial_effect(c)
	--Fusion Summon procedure
	Fusion.AddProcMixN(c,true,true,s.ffilter,2)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.hspcost)
	e1:SetTarget(s.hsptg)
	e1:SetOperation(s.hspop)
	c:RegisterEffect(e1)
	--destroy
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{id,1})
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetTarget(s.target)
    e2:SetOperation(s.operation)
    c:RegisterEffect(e2)
end
function s.ffilter(c,fc,sumtype,sp,sub,mg,sg)
	return c:IsRace(RACE_DRAGON+RACE_PYRO+RACE_PLANT,fc,sumtype,sp) and (not sg or sg:FilterCount(aux.TRUE,c)==0 or not sg:IsExists(Card.IsRace,1,c,c:GetRace(),fc,sumtype,sp))
end
function s.rfilter(c)
	return c:IsRace(RACE_DRAGON+RACE_PYRO+RACE_PLANT) and c:IsAbleToRemoveAsCost() 
		and (c:IsFaceup() or aux.SpElimFilter(c,true))
end
function s.hspcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(s.rfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE,0,e:GetHandler())
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and #rg>1 
		and aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),0) end
	local g=aux.SelectUnselectGroup(rg,e,tp,2,2,aux.ChkfMMZ(1),1,tp,HINTMSG_REMOVE)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function s.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.hspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) end
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if atk<0 then atk=0 end
        if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
    end
end