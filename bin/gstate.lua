Gstate = {}
Gstate.__index = Gstate

platform = {}
 
function Gstate.New(name)
   self = setmetatable({}, Gstate)
   self.name = name
   --self.filepath = filepath
   self.array = {}
   return self
end
 
function Gstate.load()
    
end
 
function Gstate.update(dt)
	
end
 
function Gstate.draw()
	
end



return Gstate
