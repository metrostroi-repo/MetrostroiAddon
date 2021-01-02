if SERVER then return end
local PANEL = {}

function PANEL:Init()
end

function PANEL:GetDecimals()
	return 2
end

function PANEL:Setup(vars)
	self:Clear()
	local ctrl = self:Add("DNumSlider")
	ctrl:Dock(FILL)
	-- Apply vars
	ctrl:SetMin(vars.min or 0)
	ctrl:SetMax(vars.max or 1)
	ctrl:SetDecimals(vars.dec or 2)
	-- The label needs mouse input so we can scratch
	self:GetRow().Label:SetMouseInputEnabled(true)
	-- Take the scratch and place it on the Row's label
	ctrl.Slider:SetLockY(1) --( self:GetRow().Label )
	ctrl.Scratch:SetParent(self:GetRow().Label)
	ctrl.Scratch:SetZoom(vars.zoom or 0)
	ctrl.Scratch:SetFloatValue(vars.fv or 1.5)
	ctrl.Scratch:SetDecimals(vars.dec or 2)

	if vars.nodraw then
		ctrl.Scratch.GetShouldDrawScreen = function() return false end
	end

	-- Hide the numslider's label
	ctrl.Label:SetVisible(false)
	-- Move the text area to the left
	ctrl.TextArea:Dock(LEFT)
	-- Add a margin onto the slider - so it's not right up the side
	ctrl.Slider:DockMargin(0, 3, 8, 3)
	-- Return true if we're editing
	self.IsEditing = function() return ctrl:IsEditing() end

	-- Set the value
	self.SetValue = function(_, val)
		ctrl:SetValue(val)
	end

	self:GetRow().SetValue = self.SetValue

	-- Alert row that value changed
	ctrl.OnValueChanged = function(_, newval)
		self:ValueChanged(newval)
	end

	self.Paint = function()
		-- PERFORMANCE !!!
		ctrl.Slider:SetVisible(self:IsEditing() or self:GetRow():IsChildHovered())
	end
end

derma.DefineControl("DProperty_FloatEx", "", PANEL, "DProperty_Generic")
