--- @class modifier_greevil_yellow : CDOTA_Modifier_Lua
--- @field particle ParticleID
--- @field material string
--- @field stance number
modifier_greevil_yellow = class({})

---@override
function modifier_greevil_yellow:IsHidden() return true end
---@override
function modifier_greevil_yellow:IsPurgable() return false end
---@override
function modifier_greevil_yellow:RemoveOnDeath() return false end
---@override
function modifier_greevil_yellow:IsPermanent() return true end

if IsServer() then
    --- @override
    function modifier_greevil_yellow:DeclareFunctions()
        return {
            MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        }
    end
    
	function modifier_greevil_yellow:OnCreated()		
        -- Play sound
        EmitSoundOn("DOTA_Item.Sheepstick.Activate", self:GetParent())
        -- Build greevil
        self:BuildModel()
		self:AttachParticle()
    end

    function modifier_greevil_yellow:BuildModel()
        -- Random material
        self.material = tostring(3)
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
    function modifier_greevil_yellow:AttachPart(model)
        ---@type CBaseModelEntity
        local part = SpawnEntityFromTableSynchronous("prop_dynamic", {model = model})
        part:FollowEntity(self:GetParent(), true)
		part:SetMaterialGroup(self.material)
        return part
    end

    ---@override
    function modifier_greevil_yellow:GetModifierModelChange()
        return "models/courier/greevil/greevil.vmdl"
    end

    ---@override
    function modifier_greevil_yellow:GetActivityTranslationModifiers()
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
	
	function modifier_greevil_yellow:OnDestroy()
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, false)
            ParticleManager:ReleaseParticleIndex(self.particle)
        end
    end
	
	function modifier_greevil_yellow:AttachParticle()
		local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle2 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		local particle5 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_arcs_parent.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end