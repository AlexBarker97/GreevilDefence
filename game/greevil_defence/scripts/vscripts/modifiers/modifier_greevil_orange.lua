--- @class modifier_greevil_orange : CDOTA_Modifier_Lua
--- @field particle ParticleID
--- @field material string
--- @field stance number
modifier_greevil_orange = class({})

---@override
function modifier_greevil_orange:IsHidden() return true end
---@override
function modifier_greevil_orange:IsPurgable() return false end
---@override
function modifier_greevil_orange:RemoveOnDeath() return false end
---@override
function modifier_greevil_orange:IsPermanent() return true end

if IsServer() then
    --- @override
    function modifier_greevil_orange:DeclareFunctions()
        return {
            MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        }
    end
    
    function modifier_greevil_orange:OnCreated()		
        -- Play sound
        EmitSoundOn("DOTA_Item.Sheepstick.Activate", self:GetParent())
        -- Build greevil
        self:BuildModel()
		self:AttachParticle()
    end

    function modifier_greevil_orange:BuildModel()
        -- Random material
        self.material = tostring(2)
        self.stance = RandomInt(1, 6) -- animation translation

        -- Apply material to main body
        self:GetParent():SetMaterialGroup(self.material)

        -- Add random parts
        local eyes = self:AttachPart("models/courier/greevil/greevil_eyes.vmdl")
        local ears = self:AttachPart("models/courier/greevil/greevil_ears"..RandomInt(1, 2)..".vmdl")
        local horns = self:AttachPart("models/courier/greevil/greevil_horns"..RandomInt(1, 4)..".vmdl")
        local hair = self:AttachPart("models/courier/greevil/greevil_hair"..RandomInt(1, 2)..".vmdl")
        local nose = self:AttachPart("models/courier/greevil/greevil_nose"..RandomInt(1, 3)..".vmdl")
        local tail = self:AttachPart("models/courier/greevil/greevil_tail"..RandomInt(1, 4)..".vmdl")
        local teeth = self:AttachPart("models/courier/greevil/greevil_teeth"..RandomInt(1, 4)..".vmdl")
    end

    ---@return CBaseEntity
    function modifier_greevil_orange:AttachPart(model)
        ---@type CBaseModelEntity
        local part = SpawnEntityFromTableSynchronous("prop_dynamic", {model = model})
        part:FollowEntity(self:GetParent(), true)
		part:SetMaterialGroup(self.material)
        return part
    end

    ---@override
    function modifier_greevil_orange:GetModifierModelChange()
        return "models/courier/greevil/greevil.vmdl"
    end

    ---@override
    function modifier_greevil_orange:GetActivityTranslationModifiers()
        local options = {
            "", -- Default, naked
            "level_1",
            "level_2",
            "level_3",
            "black",
            "white"
        }
        return options[self.stance]
    end
	
	
    function modifier_greevil_orange:OnDestroy()
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, false)
            ParticleManager:ReleaseParticleIndex(self.particle)
        end
    end
	
	function modifier_greevil_orange:AttachParticle()
		local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_orange/courier_greevil_orange_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle2 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_orange/courier_greevil_orange_ambient_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_orange/courier_greevil_orange_ambient_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_orange/courier_greevil_orange_ambient_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle5 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_orange/courier_greevil_orange_ambient_e.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
	
end