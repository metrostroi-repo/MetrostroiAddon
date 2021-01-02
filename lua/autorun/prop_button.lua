if SERVER then return end

local PANEL = {}

AccessorFunc( PANEL, "m_pRow", "Row" )

function PANEL:Init()
end

function PANEL:Think()

	--
	-- Periodically update the value
	--
	if ( isfunction( self.m_pRow.DataUpdate ) ) then

		self.m_pRow:DataUpdate()

	end

end

--
-- Called by this control, or a derived control, to alert the row of the change
--
function PANEL:DoClick(self1)
	if ( isfunction( self.m_pRow.OnPress ) ) then

		self.m_pRow:OnPress(self1)

	end

end

function PANEL:Setup(  )
	local name = self:GetRow().Label:GetText()
	self:Clear()
	self:GetRow().Label:Remove()
	local butt = self:Add( "DButton",self:GetRow())
	self:GetRow().Button = butt
	self:GetRow().Label = butt
	butt:SetPaintBackground( true )
	butt:Dock( FILL )
	butt:SetText(name)
	butt.DoClick = function(self1)
		self:DoClick(self1)
	end
	-- Return true if we're editing
	self.IsEditing = function(  )
		return false
	end
end

derma.DefineControl( "DProperty_Button", "", PANEL, "Panel" )
